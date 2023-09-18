%%raw(`import './SliderInput.css';`)

@react.component
let make = (
  ~title: string,
  ~state: float,
  ~underlineTitle: string,
  ~min: int,
  ~max: int,
  ~onChange,
) => {
  <>
    <div className="displayTitle">
      <span className="title"> {React.string(title)} </span>
      <span className="underlineTitle"> {React.string(underlineTitle)} </span>
    </div>
    <div>
      <input
        type_="range"
        className="slider"
        min={Belt.Int.toString(min)}
        max={Belt.Int.toString(max)}
        value={Belt.Float.toString(state)}
        onChange={onChange}
        step={switch Belt.Float.fromString("0.01") {
        | None => -1.
        | Some(v) => v
        }}
      />
    </div>
  </>
}
