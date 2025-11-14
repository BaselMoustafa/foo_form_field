# foo_form_field

`foo_form_field` is a Flutter package designed to make building and managing form fields simpler, more reactive, and fully controllable — without relying on fragile string keys or external form states.

It introduces a controller-based form system where every field owns a dedicated controller that gives you complete programmatic control over its state. Through this controller, you can:

- ✅ Get or set the field’s value

- ✅ Enable or disable the field dynamically

- ✅ Set or clear error text

- ✅ Trigger validation or saving manually

- ✅ Listen to real-time value changes


Unlike most form frameworks that depend on key–value mappings (which can easily lead to runtime errors), `foo_form_field` provides strongly-typed, direct references to each field through its controller.
This makes your forms safer, easier to refactor, and far more predictable.

🔥 It integrates seamlessly with Flutter’s native [Form](https://api.flutter.dev/flutter/widgets/Form-class.html) and [FormField](https://api.flutter.dev/flutter/widgets/FormField-class.html) widgets — meaning your existing validation and save logic will be fired automatically through the form key, just as you ordinarily do with TextFormField widgets.

# Value Conversion Model (O → I)

`foo_form_field` assumes that any form field can work with two types of values:

1. O (Output type) — the type you want to work with in your code
(example: int)

2. I (Input type) — the type the widget actually uses to display the value
(example: String for TextFormField)

This distinction exists because many Flutter widgets don’t operate in the same type you want in your business logic. For example, a TextFormField always deals with String, even if you want the actual value to be an int.

foo_form_field embraces this pattern and provides a clean way to manage both sides:

- You give the field a value of type O (your desired value type)

- The field internally converts it to type I for display

- When the user edits the input, the controller converts the I value back into O



Instead of forcing you to manually convert values each time, the package handles the O ↔ I conversion for you in a predictable and consistent way.

# Base Controllers
Any widget provided by `foo_form_field` requires a controller as a mandatory attribute.
This controller is what allows you to fully manage and interact with the widget’s value and state.

The package includes many controllers—almost one specialized controller for each widget.
(We will explain each controller later in its corresponding widget section.)
However, all of these controllers inherit from a small set of shared base controller classes.

Before exploring the individual widget controllers, let’s first look at these base controllers in detail.
Understanding them will clarify the controller hierarchy, and will also help you if you ever need to extend or create a custom controller type.

In total, the package defines  ***4 base controllers***.

## FooFieldController < O , I >
This is the parent controller for all controllers in foo_form_field.
It works with fields whose values can be converted between two types:

- O = The output type that the client (you) interacts with.

- I = The input type that the form field itself understands and uses internally to build its UI.

For example, if you have a number picker implemented using a TextFormField, then:

- O = int (the value your business logic works with)

- I  = String (the actual text value used by the widget)

This class internally extends [ChangeNotifier](https://api.flutter.dev/flutter/foundation/ChangeNotifier-class.html), which means you can attach listeners to it.
Whenever the controller updates its value, it notifies all registered listeners so your UI can react accordingly.

>### 🚨 **Important**
> Be sure to ***dispose*** it when it is no longer needed to free resources.  
> Also, ***remove any listeners*** you have added to the controller to prevent memory leaks or unexpected behavior.

### Constructor:
  ```dart
  FooFieldController({
    required this.areEqual,
    required bool? enabled,
    required String? forcedErrorText,
    required this.initialValue,
    required this.mapper,
  }) : _enabled = enabled ?? true,
    _forcedErrorText = forcedErrorText,
    _isValueChanged = false;
  ```

  - `bool? enabled`

      Determines whether the associated form field starts in an enabled or disabled state.

      If enabled == null, the controller treats it as true by default.

  - `O? initialValue`

    Represents the initial value of the form field, using the output type O that your widget logic works with.

  - `String? forcedErrorText`

    A custom error message that the field must display regardless of its validator’s result.

    When this value is not null, the form field shows this error text even if validation passes.
  - `bool Function(O x, O y) areEqual`

    A callback that tells the controller how to compare two objects of type O.
    It is used internally so the controller can determine whether a change should be considered a real update to the field’s value.

  - `FieldValueMapper<O, I> mapper`

    This object is used by the controller to convert values between I → O and O → I.
    It defines the transformation logic that allows the controller to work with an internal type I while exposing an external type O to the client and any one has ***two callbacks*** :
      
      - `O? Function(I? i) toClientType` 
      Converts a value from the field (I) to the client type (O)
      - `I? Function(O? o) toFieldType` Converts a value from the client (O) back to the field type (I)
    
    > ### **🔥 Tip** 
    > In most cases, you won’t need to create a mapper manually, because the package provides ready-made mappers for the types it natively supports.
  (These will be explained when we discuss the stand-by widgets.)

    > ### **📘 Note**
    > The naming convention for mappers is `XYMapper`, For example:
    >
    > A mapper that converts from int to String is named IntStringMapper.

### Attributes & Methods
  After creating a `FooFieldController`, you gain access to the following **attributes and methods** that allow you to fully control the attached form field:
- `mapper (FieldValueMapper<O, I>)`  
  Provides the logic to convert between the **client value** (`O`) and the **field value** (`I`).  

- `value`  ***(getter)***  
  Returns the current value of the field in your client type (`O`).

- `value` ***(setter)***   
  Assigns a new value to the field. Automatically updates the underlying form field.

- `enabled`  ***(getter)***  
  Returns whether the field is currently enabled (can be interacted with).

- `enabled` ***(setter)***  
  Updates the enabled/disabled state of the field and notifies listeners.

- `initialValue`  ***(getter)***  
  Returns the initial value provided when the controller was created.

- `initialValueAsFieldValue`  ***(getter)***  
  Converts the `initialValue` to the field’s input type (`I`) for display in the widget.

- `forcedErrorText`  ***(getter)***  
  Returns the current forced error text, which overrides validator output if set.

- `forcedErrorText` ***(setter)***  
  Forces the form field to display a specific error text and notifies listeners.

- `errorText`  ***(getter)***  
  Returns the current error message from the attached form field state (read-only).

- `hasError`  ***(getter)***  
  Returns `true` if the field currently has an error, without mutating state.

- `isValid`  ***(getter)***  
  Returns `true` if the field passes validation, without changing state.

- `isValueChanged` ***(getter)***  
  Returns `true` if the last value assignment changed the stored value compared to the previous one.

- `validate()`  
  Runs the form field’s validation logic and returns `true` if the field passes validation, `false` otherwise.

- `save()`  
  Triggers the form field’s `onSaved` callback if provided.

- `clear()`  
  Resets the field value to `null`.

- `setFormFieldState(FormFieldState<I> formFieldState)`  
  Attaches the controller to a form field, initializes its value with `initialValue`, and prepares it for interaction.

- `excute<R>({ … })` ***(protected method)***  
  Internally executes logic that requires the attached `FormFieldState`, handles listener notifications.

- `addListener(VoidCallback listener)` ***(inherited method)***

  Adds a listener that will be called whenever the controller notifies its listeners.

- `removeListener(VoidCallback listener)` ***(inherited method)***  
  Removes a previously added listener.

- `dispose() (inherited method)`  
  Cleans up the controller by removing all listeners and freeing resources. Should be called when the controller is no longer needed.



## ValueFieldController < T >
`ValueFieldController` is a subclass of `FooFieldController` where the **client type (`O`) and the field type (`I`) are identical** (`T`).  
Unlike `FooFieldController`, this controller **does not require a `mapper`**, because it automatically uses `SameValueMapper<T>()`, which simply returns the same value without any conversion.

### Constructor

```dart
ValueFieldController({
  super.initialValue,
  super.enabled,
  super.forcedErrorText,
  required super.areEqual,
}) : super(mapper: SameValueMapper<T>());
```

## ConvertableRangeFieldController < O , I >

`ConvertableRangeFieldController<O, I>` is a subclass of `FooFieldController<Range<O>,Range<I>>` that is designed to manage **range-type fields**, It takes values of type `Range<O>` from your code and provides the corresponding form field value as type `Range<I>`.

### About Range class 
`Range<T>` represents a generic range with minimum and maximum values and provides equality comparison.

- `min` (`T?`)  
  The minimum value of the range. Can be `null`.

- `max` (`T?`)  
  The maximum value of the range. Can be `null`.

- `areEqual` (`bool Function(T x, T y)`)  
  A callback used to determine equality between two values of type `T`.
  
Implements `==` operator to compare two `Range<T>` instances based on `min`and `max` values

> ### **🔥 Tip** 
> In most cases, you won’t need to create a range manually, because the package provides ready-made ranges for the types it natively supports.

### Features
- **Inheritance & Internal Controllers**

  Inherits all functionalities from `FooFieldController` and internally creates two controllers for the intended form field to pick minimum and maximum values, Both `minValueController` and `maxValueController` expose all the features of `FooFieldController` 


- **Automatic Syncing**

  Changes in the main range value automatically update the min/max controllers, and vice versa, keeping the range and its boundaries in sync

### Constructor


- This constructor is identical to the FooFieldController constructor, with the same core parameters (enabled, initialValue, forcedErrorText).

- The valueMapper and areEqualValues callbacks only apply to the range boundaries (min and max), not the overall range value.

- The controller internally manages the range’s mapper and equality logic automatically, so you don’t need to provide them for the main range value.

```dart
ConvertableRangeFieldController({
  required bool? enabled,
  required O? initialValue,
  required String? forcedErrorText,
  required FieldValueMapper<O, I> valueMapper,
  required bool Function(O x, O y) areEqualValues,
});
```

## RangeFieldController < T >
`RangeFieldController<T>` is a subclass of `ConvertableRangeFieldController<T,T>` where the **client type (`O`) and the field type (`I`) are identical** (`T`).  
Unlike `ConvertableRangeFieldController`, this controller **does not require a `mapper`**, because it automatically uses `SameValueMapper<T>()`, which simply returns the same value without any conversion.

### Constructor

```dart
RangeFieldController({
  required super.areEqualValues,
  super.initialValue,
  super.enabled,
  super.forcedErrorText,
}) : super(valueMapper: SameValueMapper<T>());
```

# Base Form Fields

Any widget (form field) provided by this package is internally a [FormField](https://api.flutter.dev/flutter/widgets/FormField-class.html) widget.  
Therefore, it’s important to understand how [FormField](https://api.flutter.dev/flutter/widgets/FormField-class.html) works in Flutter to be able to use these widgets effectively and professionally.

In this section, we will discuss the **base form fields** used in this package.  
All standby form fields internally rely on one of these foundation fields.  

Understanding them will help you:

- See how things work under the hood.
- Extend or create custom form fields as needed.

## FooFormField < O , I >

This widget is a **foundation form field** for the package.  

It **requires a `FooFieldController<O, I> controller`** as a mandatory attribute.  
It exposes **all standard `FormField` attributes**, including:  
  - `Widget Function(BuildContext context, I? value) builder`
  - `void Function(O? value)? onSaved`
  - `String? Function(O? value)? validator`
  - `AutovalidateMode? autovalidateMode`
  - `FormFieldErrorBuilder? errorBuilder`
  - `String? restorationId`

Additionally, it provides a ` void Function(O? value)?onChanged` callback that fires whenever the field value changes, giving you real-time access to user input.

> ### **📘 Note**
> The `onSaved` and `validator` callbacks of this widget will be *automatically triggered* when you use a **`Form` key** to save or validate the form, because internally it is a `FormField` widget.

> 👀 **Observation**
>
> The `builder` callback provides the field value as type `I` — the type that the field actually uses internally to build itself.  
> It does **not** provide type `O`, which is the type you prefer to work with in your business logic.

> 🚨 **Important**
>
> If you use this widget to create a custom form field, you are responsible for handling its **visual and interactive behavior**, including cases such as:  
> - No value (empty state)  
> - Error state  
> - Enabled / disabled state  
>
> All of these states can be accessed through the **`FooFieldController`** provided to the widget.

