---
toc: false
---

<!-- Load the data, build out filters -->

```js
import * as Inputs from "npm:@observablehq/inputs";
// import * as Generators from "npm:@observablehq/generators";

// Load data from loader
const envData = await FileAttachment("data/env_temp_change.csv").csv({
  typed: true,
});

// Define countryFilter and yearFilter using view()
const countryFilter = Inputs.select(
  envData.map((d) => d.Area).filter((v, i, a) => a.indexOf(v) === i),
  {
    label: "Select Countries",
    multiple: true,
    sort: "ascending",
    placeholder: "Select up to 5 countries",
    value: ["Afghanistan"],
    max: 5,
  }
);

const startYearFilter = Inputs.range([1961, 2023], {
  label: "Select Start Year",
  step: 1,
  format: d3.format("d"),
});

const endYearFilter = Inputs.range([1961, 2023], {
  label: "Select End Year",
  step: 1,
  format: d3.format("d"),
});

// use generators
const countryVal = Generators.input(countryFilter);
const startYearVal = Generators.input(startYearFilter);
const endYearVal = Generators.input(endYearFilter);

// Create a reactive view of the filtered data
const filteredData = {
  return envData
};

// Generator
// const filtDataReal = Generators.input(filteredData);

```

<div class="hero">
  <h1>Ag Production Climate Explorer</h1>
  <h2>This dashboard is designed to facilitate exploration of the impacts of climate change on global crop and livestock production. It's organized into a few different dashboards/pages, and relies mostly on data from the <a href='https://www.fao.org/faostat/en/#data'>Food and Agriculture of the United Nations (FAO)</a>.
  </h2>
  <br/>
  <h2>Explore the data below, and enjoy!</h2>
</div>

---

<div class="grid grid-cols-2">

  <div class="card">
    ${countryFilter}
  </div>

  <div class="card">
    ${startYearFilter} 
    ${endYearFilter} 
  </div>
</div>

<div class="grid grid-cols-1">
  <div class="card">${
    <!-- resize((width) => Plot.plot({
      title: "Climate Data over Selected Years",
      width,
      y: {grid: true, label: "Temperature Change"},
      x: {label: "Year"},
      marks: [
        Plot.line(filtDataReal {x: "Year", y: "TemperatureChange", stroke: "Area", tip: true})
      ]
    })); -->
  }</div>
</div>

---

<style>

.hero {
  display: flex;
  flex-direction: column;
  align-items: center;
  font-family: var(--sans-serif);
  margin: 4rem 0 8rem;
  text-wrap: balance;
  text-align: center;
}

.hero h1 {
  margin: 1rem 0;
  padding: 1rem 0;
  max-width: none;
  font-size: 14vw;
  font-weight: 900;
  line-height: 1;
  background: linear-gradient(30deg, var(--theme-foreground-focus), currentColor);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.hero h2 {
  margin: 0;
  max-width: 34em;
  font-size: 24px;
  font-style: initial;
  font-weight: 500;
  line-height: 1.5;
  color: var(--theme-foreground-muted);
}

@media (min-width: 640px) {
  .hero h1 {
    font-size: 90px;
  }
}

</style>
