# @knitr sidebar
column(4,
	conditionalPanel(condition="input.tsp!=='about'",
    selectInput("workspace", "Alfresco run", choices=wsfiles, selected=wsfiles[1], multiple=TRUE, width="100%")
	),
	
	conditionalPanel(condition="input.tsp!=='fri_boxplot' && input.tsp!=='about' && input.tsp!=='tab_ts' && input.tsp!=='ctab_ts' && input.tsp!=='tab_fs' && input.tsp!=='ctab_fs'",
		wellPanel(
			h5("Define subjects, groups, and panels"),
			fluidRow(
				column(6, uiOutput("Group_choices")),
				column(6, uiOutput("FacetBy_choices"))
			),
      checkboxInput("facetScalesFree", "Free y-axes")
		)
	),
	
  conditionalPanel(condition="input.tsp=='tab_ts' || input.tsp=='ctab_ts' || input.tsp=='tab_fs' || input.tsp=='ctab_fs'",
		wellPanel(
			h5("Define subjects, groups, and panels"),
			fluidRow(
				column(4, uiOutput("Reg_group_choices")),
				column(4, uiOutput("Reg_facetBy_choices")),
				column(4, selectInput("reg_facetcols", "Columns", choices=1:4, selected=1))
			),
      fluidRow(
        column(4, selectInput("reg_domain", "Domain", choices=c("Masked", "Full"), selected="Masked")),
        column(8, checkboxInput("reg_facetScalesFree", "Free y-axes"))
      )
		)
	),
	
	conditionalPanel(condition="input.tsp==='rab_ts' || input.tsp==='crab_ts' || input.tsp==='tab_ts' || input.tsp==='ctab_ts' || input.tsp==='tab_fs' || input.tsp==='ctab_fs'",
		wellPanel(
			fluidRow(
				column(4, h5("Time series options")),
        conditionalPanel(condition="input.tsp==='rab_ts'",
          column(4, uiOutput("TS_Site_RAB_GoButton")),
          column(4, downloadButton("dl_RAB_tsplotPDF","Get Plot", class="btn-success btn-block"))),
        conditionalPanel(condition="input.tsp==='crab_ts'",
          column(4, uiOutput("TS_Site_CRAB_GoButton")),
          column(4, downloadButton("dl_CRAB_tsplotPDF","Get Plot", class="btn-success btn-block"))),
        conditionalPanel(condition="input.tsp==='tab_ts'",
          column(4, uiOutput("TS_Reg_TAB_GoButton")),
          column(4, downloadButton("dl_RegTAB_tsplotPDF","Get Plot", class="btn-success btn-block"))),
        conditionalPanel(condition="input.tsp==='ctab_ts'",
          column(4, uiOutput("TS_Reg_CTAB_GoButton")),
          column(4, downloadButton("dl_RegCTAB_tsplotPDF","Get Plot", class="btn-success btn-block"))),
			  conditionalPanel(condition="input.tsp==='tab_fs'",
			    column(4, uiOutput("FS_Reg_TAB_GoButton")),
			    column(4, downloadButton("dl_RegTAB_fsplotPDF","Get Plot", class="btn-success btn-block"))),
			  conditionalPanel(condition="input.tsp==='ctab_fs'",
			    column(4, uiOutput("FS_Reg_CTAB_GoButton")),
			    column(4, downloadButton("dl_RegCTAB_fsplotPDF","Get Plot", class="btn-success btn-block")))
			),
			fluidRow(
				conditionalPanel(condition="input.tsp==='rab_ts' || input.tsp==='crab_ts'",
          column(6, selectInput("buffersize", "Buffer radius (km)", choices=buffersize, selected=buffersize[1]))),
        conditionalPanel(condition="input.tsp==='tab_ts' || input.tsp==='ctab_ts' || input.tsp==='tab_fs' || input.tsp==='ctab_fs'",
          column(12,
            selectInput("reg_vegetation", "Select vegetation", choices=vegclasses, selected=vegclasses, multiple=TRUE),
            conditionalPanel(condition="input.tsp==='tab_ts' || input.tsp==='ctab_ts'",
              checkboxInput("reg_aggveg", "Combine vegetation", FALSE))))
			),
			fluidRow(
				conditionalPanel(condition="input.tsp==='rab_ts' || input.tsp==='tab_ts' || input.tsp==='tab_fs'", 
           sliderInput("yearsrab", "Years", mod.years.range[1], mod.years.range[2], 
             c(max(mod.years.range[1], 1901), mod.years.range[2]), step=1, sep="")),
				conditionalPanel(condition="input.tsp==='crab_ts' || input.tsp==='ctab_ts' || input.tsp==='ctab_fs'",
				  sliderInput("yearscrab", "Years", obs.years.range[1], obs.years.range[2], obs.years.range, step=1, sep=""))
			)
		)
	),
	
	conditionalPanel(condition="input.tsp==='frp_buffer'",
		wellPanel(
			fluidRow(
				column(9, h5("FRP options")),
				column(3, downloadButton("dl_FRP_bufferplotPDF","Get Plot"))
			),
			fluidRow(
				column(6, selectInput("minbuffersize", "Min. buffer radius (km)", choices=buffersize[-length(buffersize)], selected=buffersize[6]))
			)
		)
	),
	
	conditionalPanel(condition="input.tsp==='fri_boxplot'",
		wellPanel(
			fluidRow(
				column(4, h5("Boxplot options")),
        column(4, uiOutput("Boxplot_GoButton")),
				column(4, downloadButton("dl_FRI_boxplotPDF", "Get Plot", class="btn-success btn-block"))
			),
			fluidRow(
				column(6, uiOutput("Boxplot_X_choices")),
				column(6, uiOutput("Boxplot_group_choices"))
			),
			fluidRow(
				column(6, uiOutput("Boxplot_facetBy_choices")),
				column(6, selectInput("boxplot_facetcols", "Columns", choices=1:4, selected=1))
			),
      fluidRow(
          column(12, uiOutput("Boxplot_ylim"))
      ),
			fluidRow(
        column(6, checkboxInput("boxplot_facetScalesFree", "Free y-axes", FALSE), checkboxInput("boxplot_outliers", "Show outliers", TRUE)),
				column(6, checkboxInput("boxplot_log", "Log scale", FALSE), checkboxInput("boxplot_points", "Show points", FALSE))
			),
      fluidRow(
				column(6, selectInput("points_alpha", "Alpha level", choices=seq(0.1, 1, by=0.1), selected="0.1")),
				column(6, uiOutput("Boxplot_buffer_choices"))
			),
      fluidRow(
				column(12, uiOutput("Boxplot_locgroup_choices"))
			),
      fluidRow(
				column(6, uiOutput("Boxplot_replicates_choices")),
				column(6, checkboxInput("boxplot_observed", "Include observed", TRUE))
			)
		)
	)
)
