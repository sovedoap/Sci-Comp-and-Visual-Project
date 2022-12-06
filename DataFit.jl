module DataFit

import Base.show, RecipesBase, Plots

export Point2D, XYData, linearRegression




"""
this struct makes a Point2D object with x and y as the field types 
"""

mutable struct Point2D{T <: Real}
    x::T
    y::T
end

#method to write the the Point2D point in standard form
Base.show(io::IO, pt::Point2D) = print(io, string("(", pt.x,",", pt.y, ")"))

#this is to make x and y points of the Point2D object to be the same type if they are different
Point2D(x::Real, y::Real) = Point2D(promote(x,y)...)



"""
this struct makes vector of Point2D objects 
"""

mutable struct XYData
    #stores vector of Point2D objects
    vertices::Vector{Point2D{T}} where T <: Real
    
    #constructor to take vector of xpts and vector of ypts
    function XYData(xpts::Vector{T}, ypts::Vector{T}) where T <: Real 
        #throws errow if xpts and ypts are diff size 
        length(xpts) == length(ypts)  || throw(ArgumentError("The x and y vectors are not the same size"))
        new(map((x,y) -> Point2D(x,y), xpts, ypts))
    end 
    
    #constructor to take vector of tuples
    function XYData(tups::Vector{Tuple{T,T}}) where T <: Real
        new(map(pt -> Point2D(pt[1],pt[2]), tups))
    end 
    
    #Create a constructor that creates a new XYData object from two vectors of the same length but different types (like integers and floats).
    function XYData(xpts::Vector{T}, ypts::Vector{S}) where {T <: Real, S <:Real}
        
    #throws errow if xpts and ypts are diff size 
    length(xpts) == length(ypts)  || throw(ArgumentError("The x and y vectors are not the same size"))
    new(map((x,y) -> Point2D(x,y), xpts, ypts))
    end
    

     
end


"""
this base.show prints XYData more neatly 
"""
Base.show(io::IO, n::XYData) = print(io, string("[",join(n.vertices, ","),"]"))



"""
this function plots the XYdata points onto a scatter plot 
"""

@recipe function f(n::XYData)
    legend --> false
    title --> "XYData  Scatter Plot"
    seriestype --> :scatter
    
    xpts = map(pt->pt.x, n.vertices)
    ypts = map(pt->pt.y, n.vertices)
    
    
    push!(xpts, n.vertices[1].x)
    push!(ypts, n.vertices[1].y)
return 
    xpts, ypts
end


"""
function that fin linear regression of XYdata object that gets passed in
TODO: Need to fix this
"""
function linearRegression(Data::XYData)
    m = Data.vertices[1].x
end




end #end module SciCompProjectModule