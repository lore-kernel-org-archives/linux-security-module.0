Received: from sonic316-27.consmr.mail.ne1.yahoo.com (sonic316-27.consmr.mail.ne1.yahoo.com [66.163.187.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFF6145B06
	for <linux-security-module@vger.kernel.org>; Mon,  8 Jul 2024 21:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720474818; cv=none; b=lPQSeFiccogNRwpcVJVSC295tmMtaG3pUXfJxvzCdlOE1Mqe9il4KJGbSqNWx805WDoCUuAmzrFFVWdWgohJhftUmWPQK+sJeI2iTYptCBEyFv8+NESAkcRMaRzoiZ1qy3D0qObJoJ24F4Tj50jPBrKsx7tVfAIV09mqgHKArxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720474818; c=relaxed/simple;
	bh=AwHtlWnslTP3Vscp7eqPUwKBD3oJbQJP0LUPcxmA7Mw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=paipbQJvaK1uPHc3WoLf7sfO/7ah+f9pL6nUbmIZkvGAa++buo10U+WoKHeknKRhP3E489Ml6mUw+KT1JFRWsbFAiNj7eemW6cMxowrY/2wGZCD+86nseohlolHffdBLKcAOYQycjOC3cVAoAXdQbRT1AaEqjE8gWWOoq+UpulA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=DK96b5Kp; arc=none smtp.client-ip=66.163.187.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="DK96b5Kp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1720474809; bh=7sawCs6kAFtswQkj0Alqvi2cDbAyQ2DGAg4fi5tfPYs=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=DK96b5Kpfoa7IByhj7oCaoz5RyIN1l/Jav7WBHWSbsusORInt4qSfIASYr1jVjAFubL/E/+7tZWe2lYJ654XbDZ24LZerdUiuSaZbzHonB/jnyAQc9zRTistyV+Fxk7mBBBgjtnF5vj7NE0q4RLE6BmNTuGbf+oRja3mIZHW0BBN9V5CURngcXnunlvn1IuQCaXdQg/dmR1QOTAT8h3GyUexLnKk13UTDS8dDEY+/sf01llCOnhbXhWqCRUD3maX7UIXFp9Gv1YO4B7MrPk9sGwq7QTxCgZJe4TRErfhPplAw1aK0HIXd4y0umDpBSABHIyn/YCZHkOFlIkkrpUphw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1720474809; bh=DqWM5beigCkLC9ecnfYnD8DKwhundcY9+/lxxWHNfYD=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=CRqY3i7WaYqV3QmGhH2dnAjK+bVhbB1F6L2VD+nqjSUnrrC5uGStI/ZM3y1zfZnIK2bWoZSEnlofMs2idH1SU6tnGLRmlv1C0Q+DSSAWYpy5Sqsu9e0JYD2Bcae+FDQXKKwaQqdSaTH+K24dKgrpzLSMTJRtXR0NLGcBtbFRukRiGspIbqZ8Rsc7yTjveDfOJJimk1bAlzhrl2hxyYw9kgxt1cRnID++4xSlTetd1TcKx1xFNaF8D69JXJ80zleCVerBgQQg049E96bYjYm8ARN0VQbp0jsjUwq0b8TrPe7MZECGPtAu8Ec0BTlbTO0OmtsmpXqZLq+bykjL7jLpUw==
X-YMail-OSG: jpiTQSsVM1nOO9xIWAaA98T7dP9RfUR1DCQeFME9tOt.8Y8Ms888u.fAnrH6Nxv
 kJopLAXHqbTjNOgV3nsVSdKbVoewg.uABJ1QCDoG88nIjqOUpr30iqORgLiSItDfQYXNdXJaWcit
 KMILlYpGrX7Vy1tUQaX2jw9poHbAG6EcgNkrsrrgZak6rP44I83SB8DuYo_xGEUeCSrIp0mPz266
 dl_AwPND5z8PGVg1cspiuyPb7g3ixjSUdtVZb8X0rI3CbSZtqZIhS5mhRjFO4r8dFPrdUahHzCur
 uzTjuC6XDl73c0DZ0L2pWZGqtvChVhBIdBGLArynRaTaMqPPV4N_DFaxIJcVg1V1alWpG7UK1RPb
 3JRXUKsxnC9PvCAT7hUGLQSDqcCbxxG4LpOBx6Zs_m5pd2XghM9FSDi03Ja6liq0jLUCuUjicTou
 nxzqu2LrZ4jA3g.MIdfzkUsM72pIMeaMRZI0rH9LUZ2R2FibNUaKiP8kB3oNRUEzAHur2m_KY3PL
 hI0jze58qAnVewGQ3KpTs9rK_pG2ndD_BVNjOnJbrjrcnc8lLojMEzTyQXHsiTUN_A69wYkEHFO5
 ysgP99cuvw0G7l8HAOW4XQTkmZYFrrXQiHo8gGglBnExKwCu3bqmFnDfoVpehMLXJC2gSzZV9P3e
 aB1JP3RikhVGxtZ0tgPry5aRpfNPyK9OYhFQxAUcYpSR5JbTj63.NY9LmlR86sc4ayNWV5OM1VmN
 5EFihnFotAtLa1SQEeYl8WhvTvjn0AXdGuyY8o6.oWZiKWHe.lITeHD.x_kzsb0RV6XQJudpMtxU
 ONGgqQbHgMrQ9li32doTBch1s5WTlQqvlJqh4H4Lw9u1ZTgZRYw3Ml7TBRNw41cAOPdbM4Z4m0ie
 l8xZ7apIAeDp49aulQ6iZPkGlnEiByXzrCw3jQpDrCLgqNk9fJjJuR.aWd7THLB61PiPbz1PxIqB
 6HzYQrpT1lDLx0JZujCfK5aaVwxx4vvnFVqz98.fUomV55x1kCDVRg6k8Dmq31Km9LM9WdQ.uDlU
 aC1c74C8CLj7dQ9foBcN8BRRn3TVBlfnCeqL.ljPKiOMq8L5j1NEZJ2hAoB1bAsk1cOsBUCqkSDt
 Y965L61rm8Ql_w5.xNnnQdBuIg5iB0h0j.NPz0nKVR97fqxRuY1LSFYFQX3EGA1P7PLBzuNajjBN
 OdPN86SqWY17Goi.0vebYybFxVhg.xtRDN.SUUDoyXVXRkTcqnc9YCBDYjz63xkyRACnGF.KhFX9
 ds3yyPatCqn_z4L9M1UgeYQ4bMmIYzuZynJ.n4blPG5RgyOz3OIu6PDObapB_JkZZz9KsSD9QKpv
 3vwFz5fH8G_xhlnINF_B6h7VvMa.iG4p.yCSn2dVsWV8t2UfPLXz7pUuBYfCH0ykgP0TO03.BySC
 QLX6bg6hv1UzESQENrEMbNWVBO16EDtweFEFnj9P9aJqCcxtjrJhlYxcsXd67PFhxCP1mhPf77.F
 nk.d2X3aKXp4mulm3.DYfCjJRNUzim5xio0Cel7aHOKPAzfwGcWiIWwBC7AOVUVvgROE0.Qi0nWv
 DPpsws8N6GTpGwIwinrE2CsMXxdl0Im1_cC4KydnqfOJM2t2JQff6wMPIs.x3AxSOAOrYsdVj51C
 e57WP9trf1h_dVA3kAGIPuz7fYVTMamaB2Ru2TXso99XrxryIZ5RH1wofnxUahXhjHFH6Z1.XdDt
 6sJ4Lljkl3yUoOWlWh_ikFgKl7fkt9CyWq5gsdsumZXx2b71sGyVAXJWnT0gHKK1A5YGtj796ldB
 Nvdrf8gK5xkWE_R0pkC7BMRKBy0YP_Mj2bHMk4HxvdcodYuG9Dl1wNSjDKXs5m9ryi_cLI7xIPbT
 AIXkeQ4xH8Q.bXfcHknL7v6H25WMjJoR8rmqGPJD6srFM4wahs51rL60N_Hb5z9m3vLPCRaobAvb
 XcrnTidLSPOQlRWYK0R1s3ta.rqSjZpTlYKKgd8zeD9jC3T4FT98aHoaqs_8dBHJnUJIxRJAE5OA
 5rdTkDFK27552qYDRi5H7SSSvCeC7z4HzFEt350q2JGNGPhNVDzsxCwIQU9a5Ups74Ug008ZKqJW
 d310il3g6b5sV9_JHTmZYSITp7Wob5y.aHgS1Ksa6Y3fBz1yqofbG8lFYBA6Ti_G24ioKpeqm10u
 tC3sXmKwz_91R8PgutE9BhkTpIy6blVsVhwnFW56TJLi.h2YwYC5jGq19bfyOTJlNG6eGC.rWyI0
 AmTBB3Y3v9dCIgHS5nGPsJQZs
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: fb5f052b-4644-4369-8c5f-c866f2f15731
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Mon, 8 Jul 2024 21:40:09 +0000
Received: by hermes--production-gq1-5b4c49485c-4ls9q (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 493327e53f094c0d7e867cac350cba0d;
          Mon, 08 Jul 2024 21:40:05 +0000 (UTC)
From: Casey Schaufler <casey@schaufler-ca.com>
To: casey@schaufler-ca.com,
	paul@paul-moore.com,
	linux-security-module@vger.kernel.org
Cc: jmorris@namei.org,
	serge@hallyn.com,
	keescook@chromium.org,
	john.johansen@canonical.com,
	penguin-kernel@i-love.sakura.ne.jp,
	stephen.smalley.work@gmail.com,
	mic@digikod.net
Subject: [PATCH 0/6] LSM: Infrastructure blob allocation
Date: Mon,  8 Jul 2024 14:39:51 -0700
Message-ID: <20240708213957.20519-1-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20240708213957.20519-1-casey.ref@schaufler-ca.com>

When more than one Linux Security Module (LSM) can use the security
blob for a partincular object the management of the memory associated
with that blob needs to be done by the infrastructure rather than the
individual modules.  Until now, this has been done on an as needed basis,
with the blob management remaining in the modules until such time as a
new configuration of modules requires sharing the blob.  This piecemeal
approach makes adding new modules that use blobs more difficult, as
moving the blob management to the infrastructure isn't as simple as
it might seem. This patch set moves management of the security blobs
that is done in the modules into the infrastructure. Making security
blob management more consistant improves mantainablity and makes the
possibilty of general improvement of LSM blob managment easier.

No effort has been put into pursuing the possible performance
optimizations these changes introduce. For example, sk_security blobs
might be moved to use kmem_zone_alloc(). The option of changing the
blob sizes to being compile time determined rather than calculated at
run time has been considered for future exploration.

Security blobs for the xfrm subsystem are problematic as the only
security module that implements them (SELinux) has a variable size blob
that has a published external API. Management of these blobs by the
infrastructure will require significant consideration and negotiation
with the maintainers of the existing code.  This has been deferred until
such time as another user of xfrm appears.

Casey Schaufler (6):
  LSM: Infrastructure management of the sock security
  LSM: Infrastructure management of the key security blob
  LSM: Add helper for blob allocations
  LSM: Infrastructure management of the dev_tun blob
  LSM: Infrastructure management of the infiniband blob
  LSM: Infrastructure management of the perf_event security blob

 include/linux/lsm_hook_defs.h     |   4 +-
 include/linux/lsm_hooks.h         |   5 +
 security/apparmor/include/net.h   |   3 +-
 security/apparmor/lsm.c           |  17 +--
 security/apparmor/net.c           |   2 +-
 security/security.c               | 166 +++++++++++++++++++++---------
 security/selinux/hooks.c          | 159 ++++++++++------------------
 security/selinux/include/objsec.h |  30 ++++++
 security/selinux/netlabel.c       |  23 +++--
 security/smack/smack.h            |  12 +++
 security/smack/smack_lsm.c        | 103 +++++++++---------
 security/smack/smack_netfilter.c  |   4 +-
 12 files changed, 288 insertions(+), 240 deletions(-)

-- 
2.41.0

