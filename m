Received: from sonic308-15.consmr.mail.ne1.yahoo.com (sonic308-15.consmr.mail.ne1.yahoo.com [66.163.187.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7953207
	for <linux-security-module@vger.kernel.org>; Sun, 25 Aug 2024 19:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724612464; cv=none; b=llSEgFM/KldgZzGQSf67wzlCMtIsAPURehN+rTyc26Y5mEQQDuH1ekY68Jqx0rp9yoPph+eoC7CboI48vvkkXKXNg9S4pMI6QeOhNQaGhw3SgeFQ4KgKVAYtg6vnM6n9rWoA5WES9Nb2qJcnZXESiqqDs13jvOcAqBs1ScEVsn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724612464; c=relaxed/simple;
	bh=tGbW8bnncUgykOAdZoaUTjFDl5UCz4e6lTaOlk6yj5w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=vBM82Z84JufqRnvJFMUFlPlB08hunmLC8+VDiAb1LcCeOyqYGVTdXeEx+QK/C8RosuqXs4dFY70614H/Rz5qxxVpCFveyC/H6hrndunPqHSkkNwKQQmQn6nXKFdxsP+UKiDjFu7cnvPwqPm3mQ2zByGSlkDMCrYkHEIQ6EiFOqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=o4I+PUH3; arc=none smtp.client-ip=66.163.187.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="o4I+PUH3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724612456; bh=AS+FK1AGsQQ04z3FAS43aukkLdehuf3DAyx12Boba/0=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=o4I+PUH3zGrOY0xOQS5b6MC0HW0ivSf67V0rK/5R4Mu8bnK2h5tp9NVCwGeKt24AWSN4wfUtKsotRsFISsXj1msKXn6+j53+ghXqFB2g/YADyj9s1g1fgPjtCy26jHi9uI57I39dbhVnHMffS7G6ZZJxjcJhcd+enpv3ouUpwA1iIqTs1tblOdPvyshNRWMKgsmYCEPysTaq4ARzfGlOtf34UVDT+8FPW2NB4+wj2FXyKcqoFUyfyub/NO5yA80/wdDwI83sJ9gQwrs/cE+724ClNbupyJD9tP9OwFHrwvzJOaQKvJYRlsPfcz4nyWhkz7QX8Mkk60YKFiKsUDKsQQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724612456; bh=TfN26Mvac2AdJWqGRIUwv+taXfCVADN1GslkodC+iXr=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=W4bxpwu1HC6wsoeWgtsKshNiuQODom1upmjqQcPa3MF4ebg3JUNCHTNmYMmjWImlswh5GV3KmZVkoG5zjMbIVqE1twDa87cZyN76FBmMMHDzDyJok6Np0b0o3iPVhHzmAZUSNWfoAFJpZmzYRudr9YfIifcWNSNWsgH3WOGb2y0+7lJHxwcYF+ejgI3n7JZMO5dZDfKWHdIBtiP86BSLOQ2aob7b5AKfUOMyf+BOlpEyaMoqRds6Zls+jqh/ahiftgCWu7gl0vb0nAmSc9HzAWrq1uw9P/swvxQj+wBl7jS7hWoP8k5UpyJdqh6GyWWrFh93gAeelOtiKGDEuX5sCw==
X-YMail-OSG: qtnPlLMVM1lDV2pqQu75otO1bQm9iAUdwmOpE_cIOZ5uTc3JmaC.miORN9cS5XP
 0hIeaSQ2MCzWx3Upv9Ekh19sdkmpqh4JZsVPcunYKS5xHfOV3SG9HOuL8..JJKSX9aNLifF5umYJ
 OZcuDJFotU4MEtey5Bn5J06ftRRcgg0I9Ag735XyNbPHNY52ZEwVyD06gFacZC4F4nz2ArBwY8q2
 cSL5pYNhkltNZ6PpjHr9oJb7_3jFWB_jh0e02eIGv_3tQhX_jca.zTtqked66tn8830imVG20u_l
 eiPjGifp0lBxOK7WN7E0JgPy3KRYiIkgrj2fENAgD2UMcZljT5c8Brx6e_Rv8wuX.j2c3JLx_82b
 s42bpSqlxXldirFI5kFDy0PhKSncncHGVZq.6KMfre707BsK0QdBzpMTrk8CwfIiz0fbKmiqxPBi
 yFX3e2LynqxSeq1orroDAh9RyrQaKU1cc_wwTJnB_E6mAzUhNM9MdcYPvOQ2pe0GFxupoQsjTwW8
 NAxdvUBKdPC.uoyy64RLMFRChhfG8aRJltm6KhK7i5iY6cTsZS7Kk7LvB3Ihfhv2vVkbLm4OaivZ
 df4_ZPlMuITS40BB2ZSDvzOYHV9LwQTdlniW_EunPUAyJNBxxTqtptDUuNnd1Wam_gJaDGnrXy41
 tuGfN3WZeGb8USMCzHBtmgE8N4rgQ0ct.0Ctd4zbBNWNNSzgTqgyIbuqm_NNl3nwW3d9RyBHBlrd
 Eha6DOMelqUm07PdrKiiXN1L4Rqg_r7EgON1RZhuV686yG7SknIKcKEuKo.Inu8iNSXSjgGUFa7Y
 .f.zr9Ey2ki90XTo3yGP6xXW_HlQQV98L46Y.KaH.CxDUrC_rdQiXBtownaSQcIMzw3azBNjan4i
 yckDZr2f_I_nNhUJKbz5xAUnC83Yl24bEKATw.P1XthMYBLyc4OGwDyPuCQTghk6r7WW0Jq_BuiS
 JcSdQl_cxDEItVEsMXc06H6kWvRKvMx3EZKc4q1wYxBQsWOFOHl0vwltIEf7oUuyXWHCr1vrW7Ll
 ffN1S9iupZkfHPNVIq12VdoFF_Q1YfTtH9f1PZbc2h9SlFlhGEb3kTpxEVFNMOISUc_M.W.WlINM
 RyY5Y8272YT2lusnPntuvweHW.wXbWeN3L6drh9L1aH1aRmPYGOgmXtJEtRDZqaaXGkZZttpSHqQ
 RfjZ.nnOfD2wxQ18U_JSUTRDipFp00qsxWQvwNIAp5puiPaujXz_aatcV9Sxn4OCfJ5B_EV4.Rrf
 YK5qut3fAMz4v5y6IlX6l8oXa49ogguD2EUfoDgLR9jxaa9kNr6f8r.Aq6XHdJe07xxjtU6hsm2a
 8Va4_Fn17kYtwmY9OhosEg3nWrHeBn8XFSMieadnILEpC4X9hANW6cVchc_rcvQ13pnoSPwPSPI1
 XZ3IkUz9CuEwQmIZGpIYj4I_MMn.G9i.vRzfFIviKBtmGioo_GKAVqxh5QL8.3SHGDZjYMB6ok7l
 u6A0KIzC4GWHQFLKDKcVhhF7yBnmyfZRAfStO_2QNxudxWJWZMdx.G2QENMUvXohGEH9yg1NF.GV
 4FvGzSDNMKQTvm.pAOgm07cIVavcRJZph0f_f36LH3f2dGCc9.6PenUe7ix9c0g9xo_kgU70SqtG
 DhAo80ujo5FgEcsVkl6knoxadZn6Av4S2jVq2J_P3of7SQKOPAvqYSIadBCZJpVRg0l6ekOs48z8
 GXdFqU6ZVF7lTCmJ3oGNhRUZ4RAF3Ow9FOo0WRUyAtzMEsfrDhxCYS3_fnuBJ9giX.tCApS1ahnp
 As4p97o6_hz8ydRoiBbhpnfM6PCbtFhM4doBH_TpURADbJfc437ZXXqtiUrzwwbrK5xMEkvEKiYq
 kFC1sa9Tb2pDDemMSAtxnVTWsLSqH02GpkdR.nbyLDXBQLsKKNRlA3M5TpMU9yRF_amRdaiR0uNR
 GI_1smb52Kx.FqFEOAe3QYKZpGSAmiRfalTt0YTZRC1BdophpIi1t3_qjZ1XlN2yvYH3GbffV2yO
 2akB1Dq.AadSozKF1jYGgSzLudrxzbMG.mFuCy7EgLswTXjg5A3ajRR7HWy0.yQJwij0uxQJCrM8
 EgGw8hPltABCHzk_BWT395ZGvx7_uonC7.y3HDmENZzEEYf2RmXbhAaxJDyeBItzH7sLZtGyRSZv
 AD1WWStjQRwUEbZ9rtEK4jNSEyfLA4m4MG2AcuBWMgrHnyCSPwdHrJKdsrO1OrihcyO532VHR0by
 Np8HSBgNi388JTf3XQlcdyudjOYvy96vwDrbysDvGBANVL0EiIH2xMnuIYxF4_nLnPyUb.GNbOOI
 qmvRE11v6X8QcGikk9Vz1MrR3ysy8Lw--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 9148ce17-03a4-4f07-94ad-ee90928dcc83
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Sun, 25 Aug 2024 19:00:56 +0000
Received: by hermes--production-gq1-5d95dc458-rvnnh (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 6fc1ee0505485e3267054d717b5fc74f;
          Sun, 25 Aug 2024 19:00:54 +0000 (UTC)
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
	linux-kernel@vger.kernel.org,
	mic@digikod.net
Subject: [PATCH 00/13] LSM: Move away from secids
Date: Sun, 25 Aug 2024 12:00:35 -0700
Message-ID: <20240825190048.13289-1-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20240825190048.13289-1-casey.ref@schaufler-ca.com>

Many of the Linux Security Module (LSM) interfaces use u32
security ID values (secids) to identify module specific security
attributes. This is an artifact of the SELinux security server
architecture and compromises made to allow security attributes
to be associated with networking mechanisms. There are significant
performance implications to using this approach, as access control
decisions must map the secids to the real data to be used. There is
also impact on the audit system, which must provide textual values
for security attributes.

The secid based interfaces are also constrained to supporting a
single security module. There are clever mechanisms for representing
multiple 32 bit values in a single 32 bit value, but they add overhead
and complexity. While the issue of multiple concurrent security modules
is not explicity addressed here, the move away from secids is required
to make that possible.

Most uses of secids can be replaced by a security module specific
value. In SELinux this remains a u32 secid. In Smack the value is
a pointer into the system label list. In AppArmor a pointer to a
security context can be used. Because the active security module can
be specified at boot time using the "security=" or "lsm=" flags,
the system must be able to use any of the possible values.

A struct lsmblob is introduced to contain the attribute values.
This struct includes a member for each of the security modules that
are built into the kernel. Where possible, uses of secids are
replaced with a lsmblob. LSM interfaces have been modified to use
lsmblob pointers instead of secids in most cases. Some new interfaces
have been introduced where it is not practical to replace an existing
secid interface. This occurs in several networking code paths.

https://github.com/cschaufler/lsm-stacking.git#lsmblob-6.11-rc3

Casey Schaufler (13):
  LSM: Add the lsmblob data structure.
  LSM: Use lsmblob in security_audit_rule_match
  LSM: Add lsmblob_to_secctx hook
  Audit: maintain an lsmblob in audit_context
  LSM: Use lsmblob in security_ipc_getsecid
  Audit: Update shutdown LSM data
  LSM: Use lsmblob in security_current_getsecid
  LSM: Use lsmblob in security_inode_getsecid
  Audit: use an lsmblob in audit_names
  LSM: Create new security_cred_getlsmblob LSM hook
  Audit: Change context data from secid to lsmblob
  Netlabel: Use lsmblob for audit data
  LSM: Remove lsmblob scaffolding

 include/linux/lsm/apparmor.h          |  17 +++++
 include/linux/lsm/bpf.h               |  16 ++++
 include/linux/lsm/selinux.h           |  16 ++++
 include/linux/lsm/smack.h             |  17 +++++
 include/linux/lsm_hook_defs.h         |  20 +++--
 include/linux/security.h              |  90 ++++++++++++++++++----
 include/net/netlabel.h                |   2 +-
 kernel/audit.c                        |  21 +++---
 kernel/audit.h                        |   7 +-
 kernel/auditfilter.c                  |   9 ++-
 kernel/auditsc.c                      |  61 ++++++++-------
 net/netlabel/netlabel_unlabeled.c     |   2 +-
 net/netlabel/netlabel_user.c          |   7 +-
 net/netlabel/netlabel_user.h          |   2 +-
 security/apparmor/audit.c             |   4 +-
 security/apparmor/include/audit.h     |   2 +-
 security/apparmor/include/secid.h     |   2 +
 security/apparmor/lsm.c               |  17 +++--
 security/apparmor/secid.c             |  32 ++++++++
 security/integrity/ima/ima.h          |   6 +-
 security/integrity/ima/ima_api.c      |   6 +-
 security/integrity/ima/ima_appraise.c |   6 +-
 security/integrity/ima/ima_main.c     |  60 +++++++--------
 security/integrity/ima/ima_policy.c   |  20 ++---
 security/security.c                   | 105 ++++++++++++++++++--------
 security/selinux/hooks.c              |  49 +++++++-----
 security/selinux/include/audit.h      |   5 +-
 security/selinux/ss/services.c        |   7 +-
 security/smack/smack_lsm.c            |  95 +++++++++++++++--------
 security/smack/smackfs.c              |   4 +-
 30 files changed, 483 insertions(+), 224 deletions(-)
 create mode 100644 include/linux/lsm/apparmor.h
 create mode 100644 include/linux/lsm/bpf.h
 create mode 100644 include/linux/lsm/selinux.h
 create mode 100644 include/linux/lsm/smack.h

-- 
2.41.0

