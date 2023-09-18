@react.component
let make = (~data) => {
  open Recharts

  let displayCell = (data: array<ChartData.chartData>): React.element => {
    data
    ->Belt.Array.map(entry => {
      Js.log(entry.color)
      <Cell key={"cell-" ++ Belt.Int.toString(entry.uv)} fill="#ff9896" />
    })
    ->React.array
  }

  <PieChart width=800 height=400>
    <Pie
      data
      dataKey="uv"
      cx=Px(150.)
      cy=Px(250.)
      innerRadius=Px(60.0)
      outerRadius=Px(80.0)
      fill="#82ca9d">
      <div> {displayCell(data)} </div>
    </Pie>
  </PieChart>
}
