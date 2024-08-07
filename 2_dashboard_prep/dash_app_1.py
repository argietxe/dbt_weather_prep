#import
import pandas as pd 
import dash
from dash import Dash, dcc, html, callback
from dash.dependencies import Input, Output, State
import plotly.express as px
from dash import dash_table
import dash_bootstrap_components as dbc


# custome template
custom_template = {
    "paper_bgcolor": "white",  # Background color white
    "plot_bgcolor": "white",   # Background color white
    "font": {"color": "black", "size": 10},  # Ticks black and small
    "xaxis": {
        "showgrid": True,       # Grid visible
        "gridcolor": "#F0F0F0", # Very light grey
        "gridwidth": 0.5        # Very thin grid
    },
    "yaxis": {
        "showgrid": True,       # Grid visible
        "gridcolor": "#F0F0F0", # Very light grey
        "gridwidth": 0.5        # Very thin grid
    }
}

# custom color mappings
custom_colors = {
    'Auckland': '#C6082C', #C3BA27
    'Biarritz': '#C3921E', #929292
    'Berlin': '#230A2A', #FDA929
    'Reykjavik': '#8D2013', #A9C7FC
    'Vancouver': '#013C40' #F0CBFD
}
929292
# custom_black
grey_colors = {
    'Auckland': '#A9A9A9',
    'Biarritz': '#A9A9A9',
    'Berlin': '#A9A9A9',
    'Reykjavik': '#A9A9A9',
    'Vancouver': '#A9A9A9'
    }

#for season color
season_colors = {
    'Winter': '#C7E2E7', #C3BA27
    'Spring': '#8A73A1', #929292
    'Summer': '#C3921E', #FDA929
    'Autumn': '#8D2013', #A9C7FC
}


#temperature season
#import data
temp_season = pd.read_csv('./data/mart_temp_season.csv')
temp_season.sort_values(by='city', inplace=True)
custom_dict_season = {'Winter':1 
                    ,'Spring':2, 'Summer':3, 'Autumn':4}
temp_season= temp_season.sort_values(by='season_name', key=lambda x: x.replace(custom_dict_season))

#plot
bar_temp = px.bar(temp_season,
                     y="avg_temp_c",
                     x='city',
                     color='season_name',
                      barmode='group',
                     color_discrete_map=season_colors,
                     height=400,
                 title='Temperature distribution')

bar_temp.update_layout(**custom_template)
bar_temp.update_layout(showlegend=False)
graph_bar = dcc.Graph(figure=bar_temp)   #dash figure


#app
app = dash.Dash(external_stylesheets=[dbc.themes.DARKLY])

#defining the dropdown before to make it less crowded in the dash.layout
dropdown = dcc.Dropdown(options=['Winter', 'Spring', 'Summer','Autumn'], value="Winter", clearable=False) 

dropdown_city = dcc.Dropdown(options=['Berlin', 'Biarritz', 'Auckland','Reykjavik','Vancouver'], value="Berlin", clearable=False) 


app =dash.Dash(external_stylesheets=[dbc.themes.DARKLY])
app.layout = html.Div([html.H1('AN IDEAL PLACE TO LIVE', style={'textAlign': 'center', 'color': '#636EFA'}), 
                       html.Div(html.P("Using the gapminder data we take a look at Germany's profile"), 
                                style={'marginLeft': 50, 'marginRight': 25}),
                       html.Div([html.Div('Winter', 
                                          style={'backgroundColor': '#636EFA', 'color': 'white', 
                                                 'width': '900px', 'marginLeft': 'auto', 'marginRight': 'auto'}),
                                 dropdown, graph_bar])
                      ])

# now making the link between dropdown and dataframe's graph
@callback(                            # or app@callback()    #you can make one callback influencing many figures too if you want.
    Output(graph_bar, "figure"), 
    Input(dropdown, "value"))    

#Output(component_id='my-output', component_property='children'),
#Input(component_id='my-input', component_property='value')

def update_bar_chart(season): 
    mask = temp_season["season_name"] == season # coming from the function parameter
    one_season = temp_season[mask]
    bar_temp = px.bar(temp_season,
                     y="avg_temp_c",
                     x='city',
                     #color='season_name',
                     #barmode='group',
                     color_discrete_map=season_colors,
                     height=400,
                 title='Temperature distribution')

    bar_temp.update_layout(**custom_template)
    bar_temp.update_layout(showlegend=False)

    return bar_temp # whatever you are returning here is connected to the component property of
                       #the output which is figure

if __name__ == "__main__":
    app.run_server(debug=True)  #run on python #develop mode
