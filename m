From: joe@perches.com (Joe Perches)
Date: Thu, 16 Nov 2017 07:27:25 -0800
Subject: [PATCH 0/4] treewide: Fix line continuation formats
Message-ID: <cover.1510845910.git.joe@perches.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Avoid using line continations in formats as that causes unexpected
output.

Joe Perches (4):
  rk3399_dmc: Fix line continuation format
  drm: amd: Fix line continuation formats
  [media] dibx000_common: Fix line continuation format
  ima: Fix line continuation format

 drivers/devfreq/rk3399_dmc.c                       |  4 ++--
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c   | 11 ++++-----
 .../amd/powerplay/hwmgr/process_pptables_v1_0.c    |  6 ++---
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c | 27 ++++++++--------------
 drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c   |  6 ++---
 .../gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c  |  9 +++-----
 .../gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c   |  6 ++---
 drivers/media/dvb-frontends/dibx000_common.c       |  8 +++----
 security/integrity/ima/ima_template.c              | 11 ++++-----
 9 files changed, 33 insertions(+), 55 deletions(-)

-- 
2.15.0

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
