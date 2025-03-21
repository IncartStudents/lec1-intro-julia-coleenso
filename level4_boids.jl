module Boids
using Plots

mutable struct Boid
    position::Tuple{Float64,Float64}
    velocity::Tuple{Float64,Float64}
end
mutable struct WorldState
    boids::Vector{Boid}
    width::Float64
    height::Float64
    

    function WorldState(n_boids::Int, width::Float64, height::Float64)
        # TODO: добавить случайные позиции для n_boids птичек вместо одной

        boids = [Boid((rand() * width, rand() * height), (rand() - 0.5, rand() - 0.5)) for _ in 1:n_boids]
       # new(position, width, height)
        return new(boids, width, height)
    end
end

function distance(b1::Boid, b2::Boid)
    return sqrt((b1.position[1] - b2.position[1])^2 + (b1.position[2] - b2.position[2])^2)
end

function update!(state::WorldState)
   # state.boid = [Boid((x + randn() * 0.5, y + randn() * 0.5), (rand()-0.5, rand()-0.5)) for (x, y) in state.boid]
   upda!(state::WorldState)
   # new_boids = Boid[]
   # state.boids = new_boids

    # TODO: реализация уравнения движениcleaя птичек

    return nothing
end

function upda!(state::WorldState)
    separation_factor = 0.2
    alignment_factor = 0.05
    cohesion_factor = 0.01
    perception_radius = 10.0
    max_speed = 2.0

    new_boids = Boid[]

    for boid in state.boids
        neighbors = [b for b in state.boids if b !== boid && distance(b, boid) < perception_radius]
        
        separation_force = (0.0, 0.0)
        alignment_force = (0.0, 0.0)
        cohesion_force = (0.0, 0.0)

        if length(neighbors) > 0
            for neighbor in neighbors
                dx = boid.position[1] - neighbor.position[1]
                dy = boid.position[2] - neighbor.position[2]
                dist = distance(boid, neighbor)
                if dist > 0
                    separation_force = (separation_force[1] + dx / dist, separation_force[2] + dy / dist)
                end
            end
            separation_force = (separation_force[1] * separation_factor, separation_force[2] * separation_factor)

            avg_velocity = (sum(n.velocity[1] for n in neighbors) / length(neighbors),
                            sum(n.velocity[2] for n in neighbors) / length(neighbors))
            alignment_force = ((avg_velocity[1] - boid.velocity[1]) * alignment_factor,
                               (avg_velocity[2] - boid.velocity[2]) * alignment_factor)

            avg_position = (sum(n.position[1] for n in neighbors) / length(neighbors),
                            sum(n.position[2] for n in neighbors) / length(neighbors))
            cohesion_force = ((avg_position[1] - boid.position[1]) * cohesion_factor,
                              (avg_position[2] - boid.position[2]) * cohesion_factor)

        end

        new_velocity = (boid.velocity[1] + separation_force[1] + alignment_force[1] + cohesion_force[1],
                        boid.velocity[2] + separation_force[2] + alignment_force[2] + cohesion_force[2])

        speed = sqrt(new_velocity[1]^2 + new_velocity[2]^2)
        if speed > max_speed
            new_velocity = (new_velocity[1] / speed * max_speed, new_velocity[2] / speed * max_speed)
        end

        new_position = (boid.position[1] + new_velocity[1], boid.position[2] + new_velocity[2])
        new_position = (mod(new_position[1], state.width), mod(new_position[2], state.height))

        push!(new_boids, Boid(new_position, new_velocity))
    end

    state.boids = new_boids
    
end

function (@main)(ARGS)
    w::Float64 = 30
    h::Float64 = 30
    n_boids = 10

    state = WorldState(n_boids, w, h)

    anim = @animate for time = 1:100
        update!(state)
        # println(boids)
        scatter([b.position[1] for b in state.boids], [b.position[2] for b in state.boids], xlim=(0, state.width), ylim=(0, state.height))
    end
    gif(anim, "boids.gif", fps=10)
end

export main

end

using .Boids
Boids.main("")
