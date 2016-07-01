import UnityEngine

public class ScrapeHandler(EffectPool):
"""
Spawn an effect prefab at each contact point
"""

    public def OnScrape(col as Collision):
        for c in col.contacts:
            Spawn(c.point,  Quaternion.AngleAxis(0, c.normal))
