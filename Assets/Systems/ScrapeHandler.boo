import UnityEngine

public class ScrapeHandler(EffectPool):
"""
Spawn an effect prefab at each contact point
"""
    public _SmallParticleCount = 100
    public _LargeParticleCount = 2000
    public _LargeThreshold = 50.0f

    public def OnScrape(col as Collision):

        m = col.relativeVelocity.magnitude / _LargeThreshold
        for c in col.contacts:
            emitter = Spawn(c.point,  Quaternion.AngleAxis(0, c.normal))
            ps = emitter.GetComponent[of ParticleSystem]()
            ps.emissionRate = Lerp(_SmallParticleCount, _LargeParticleCount, m)
