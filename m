Received: from sonic306-27.consmr.mail.ne1.yahoo.com (sonic306-27.consmr.mail.ne1.yahoo.com [66.163.189.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB142C6A3
	for <linux-security-module@vger.kernel.org>; Tue, 19 Mar 2024 17:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710871146; cv=none; b=kb2Wc1EUdOMxn45zwEA3J2wDOiuyxxSO9UBe5C+cR2K3BWiThc2vXmHrah+IPICV/eBTlIlam2rXszsEFNWlumjYXM+TdUagfQH2hBqW977xW/4fec0voZTpAGL4sZqu0POgL51r1Ibbe6JUaNw9eiLFBuZrInCiVckySTk6vh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710871146; c=relaxed/simple;
	bh=WOyhpXnZXG2HkYyxUBv9JvKcWajoEnD0Ho6SnidlHsY=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type:
	 References; b=P0Zk6Us2sy58ghHywEBVArh/OWD/cTGniE0kjkW1Cf7uaskPGQNIUB1mxXQKgR77CSNhBz8h612PtMJi/pqaFMJPAt5iJRwg9MazfGxD+n3LzD5b8E8CyUsEtq3t4EEKQglxRkwMZGkooEkd+V2YpkSy+K/k9crINTZrdaz3Khg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=UvfnqR41; arc=none smtp.client-ip=66.163.189.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="UvfnqR41"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1710871138; bh=yAMGXnODg4zpsUzoZYF4fw5Fi5nz+vnB8cdUPCWIK/k=; h=Date:To:From:Subject:References:From:Subject:Reply-To; b=UvfnqR416g8YvLvg3kJm9AB1UdLRx5UJ0l9VhAOqR/KxmrMLNSXFLdzxd1BMF3rFVIaDqschEHtwc3SJyrRIniIa+LASN7tUov0nznEr8N+EdYL7PntTFE7cEHrZK5EirfsGsUturR3B3/M07jYQ2yh01VJb7yn88ecHWyeO2WmIIgnPJf/8xDir3hi36pB+ZhE2PoFffzGrCJ1PRlrQGkrvPsavb9Jq1J1rPRC8JL+gO/KUbPdcs+iPHIZbi5J/M3Ej9SBE74StuvtgD3kh5ikk7tDqFUfzvgJnDsAHVqGS0KR4vEH2ivfkWMXaU4+4T8yMW6HxvDV2q1xPhJP9Mw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1710871138; bh=yMkcFQFNwBJoTy0hDbew8v34vQyqjly17KiNi4j+e5s=; h=X-Sonic-MF:Date:To:From:Subject:From:Subject; b=fpfiOKYuO9nchY1j2z7cqMT2F5FRq7LeBM9kb4IF3QYdvk3UIp6mIQUj7z6lSe3MVm7YfjG+ulupPNUYloX2WOdZj5CMbnmqIOirLQmCvKTw1JjiJQKjTSOXDFZ1t5f3TaAvaAJ0Ar8+qVR66S9Qw45iRfN6eQm+srCSIjVIpJkSnUt0moq9BEDOOfFE1t8uWX6bU2QHXdtO947faoPXcy7Zgl4O0cUmO25SPq8i22D/kab4qlQnDHNYxNmH4HDnVzX3b4EgnKTH7K4BcQ2IIAd3Xvk9kARc+ywwDgTmknNlMQXLGxjQIyY+EEYfdpUnbu7KzMzDUdTCD0ZOdp366g==
X-YMail-OSG: CYPDwaIVM1mvcxWz9uq6F.ACg02EHerwHRj9I_xes67Xe6XSp33mWzz225kOjlV
 rubX53eLjvSMawxsojv9ADVFSPD.A8z2e0iXtK1ADe3PYVzvd8kzUh5Wg_jCwAnxjr4kRVwFk2BP
 WCL4u2NgMOedgbK8ZemJJSQkpIxcAvl7kePpusbrOKtyNyc8O88yAZNznM0RkB492FNa4j14jNJ4
 3DPqNskOdcfTdCFcr0v9qF2.RvlSwk57SXWU8Wxp8M7uaLDsHSoeINoRo3JcAWd3epgsTdIbGxLP
 W2ZC3OABcH0gVXoxmA9P2UUBf4b3BDYfIZ5X1fmUIEQYKzJX1QXaPdDzcElHX1rdiZAvNh8kpIIu
 4tIqt.HcobFnnIOphqMYIsKWpuZbl0EehS77kkMwMN8TUYuxMmAo8HjyI8Ws6CIjW5ZUPvj.ybd0
 FkGfh1polpPLCnjIJ_zRBDm9DDC3wTTi9mP3vDwX5zqCCb8rxW4c3Owg1dyhZVTePGLiWlv.4pfs
 SXx68q6kPB6PGN0wASEO4FUat7_SPfBMymLbof1x3JQs6k2cxGDnYLjjjoOi.QdGxaq1N34IWBwP
 5FakHywBy1JoD6aRirsX9paKJmxa5ZPq9qZ0OOBU_L3s33Ar9zgFd7cYFZbzGgJ1dwxnrf4W18dF
 sgTiAVAEmAXNS0yyyutBgr6QR.VkW9Q87Elr1Gk_6L671MJYoAFZUVBCgVhkQOaurcxNFLyjJket
 VclNytQcxfkj0PPRKhnYZXDnUgKOFY74bnMo2n4ocPzgQ7.Aa9gEnnDzTVuRcGwcQqwW47T9TzaV
 9QizbAJlaXTgizU4f_Phrg.AsCI3xyrz9psh5QEMgHDknWEWdxGDNRIN84NUBzGld3bg9Wv.PziA
 IBLzu4G6cKviL5oyhMQwXF2JHhh6TA.EpUWTh.8Dh.kLGHsaoetStBXIKucd53_GlVGMmSR_Eo1H
 mPul8TzLAjgN95RdYAUNmN8qzovwkKNHyR2QHEBqU_GNyunDIF_fnDreAVL7DkIAtWmz4bT3LZaY
 0Be2sewpS4v4r_c7b08I0oOCF2XIV3e8kAU6qLu1VaawoLNhhiLZssocbY3Suv3rEke5OUL5BXt2
 Zkk.Svasi8fQlRmbFeNvWuUQXZ6w7bmIJ5NM4MVNi3Mjeqcj65YuDBo.DeAdQScsDdlwp3UC3nNM
 yLXOYKm_dDL.fM2EhTLgpRnfrhyNgmvg7kxYyH.ctIoS8982RVG6muXaWHYCjdfHb91nrCZLGi8l
 z1JUDDRAPDosRJy6P3QSHiTlGdvoDiTInj1XZ5KLq6uRLZmJhT_YaW9Bhf5x2DOWzJOjrLGQI4Fq
 9Rovid0PiTecz73EoHFrZhR7DPnZ1a2pli86kvtBexO.LPhn31FuTH1UFwaLBCq5JMpXQjvNwp52
 m8XCEm4EvakxmlfAgWwM5YDmqAklEx.aIcqEUsjXDBg_q6xKS8udvp3vxrIGVzCGZXn7RDJvfUtD
 YlAK41c.YPmCnAAcvWUCGy2v8AgtwyyEt6cvF6kkzXuUd4Qa367uup8kV8FAUYy_Gy76b.sCnyMM
 t1flipc6W1_ANZTS18d.T3np2evScc3RefRzid.FFENxVaVW9loHComxFAb5YpjiESdoo.cPta6w
 _ipoyPmIqryW0U9VVlyIwIVa5W6LLxQgWNjeCYAuh5kOyueYY0cJteZFmK5kOKXGQqHO_jl3.KJo
 n2TJinWcpXhPcjNkSQrKao6ES1KnKyzYUnAZ5GhpT4X1jm.USNFvTm06GuANp_1i9aW1ii_I2e2Q
 OYVwYUma1pTHbrs1C7ZhLTGGnSfovbjDT7KgFJJ.eTDBScSokt4aXrMx5rOVqlw1CSi78y3XAD7A
 aDB4kDT5MHW92OIvNpXBgOcginMHiOSWtnd9aAp8WzwWcXyYlAurHVxMvnvSYsBJIlNCxDlaq8Uv
 IbCxRShdaQFS_doIHZgULoxAyEQ1.aZuWXTk5PtWZPTPes0B0.cWopPwX7t7bK5sz15fSRl5TmRd
 MoJNZ3iO47IlxUYXBsnEYnSnSy4k2sRomsbaSMLJOAZyq0wvVStwsccXYklJ8bmN.Y9mTF5m7PXU
 O9Cz1MBuCUxVxHplnL0GAhXENkr3CyShz6efVgIja41n7Y07bUDU36mvT2yuG4RIwpx.YD.LH3LO
 RCvfGLrfthwHRyICGIsR7GVhQZIxknkRvBy5OitLU_5B6kiCU4wb38qGt24qY3Mfq8rGpAbrqLrH
 J14oNs8UCS1ImzHfuXPi6FDcfCEY.n_ci4eob0Rvjz03lIITxzv9hq88t
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: fc6d8231-80af-4a9d-851d-1e5b2af22e8c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Tue, 19 Mar 2024 17:58:58 +0000
Received: by hermes--production-gq1-5c57879fdf-4h5cs (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e78ee299e78406429387b409de7e26b3;
          Tue, 19 Mar 2024 17:58:55 +0000 (UTC)
Message-ID: <255cd7ad-332c-473f-8059-3258dad287a7@schaufler-ca.com>
Date: Tue, 19 Mar 2024 10:58:54 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: LSM List <linux-security-module@vger.kernel.org>
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: Systemd v254 LSM stacking issue - patch
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <255cd7ad-332c-473f-8059-3258dad287a7.ref@schaufler-ca.com>
X-Mailer: WebService/1.1.22129 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Systemd version 254 (included in Fedora 39) has an assertion that
only one of Smack and SELinux is active. This can make experimenting
with full LSM stacking frustrating. This patch adds multiple label
operation support and removes the pesky assertion. It's experimental.

---
 src/basic/label.c       | 48 ++++++++++++++++++++++++++++++++++--------------
 src/core/smack-setup.c  |  2 +-
 src/shared/label-util.c |  2 --
 src/shared/smack-util.c |  2 +-
 4 files changed, 36 insertions(+), 18 deletions(-)

diff --git a/src/basic/label.c b/src/basic/label.c
index f134e77589..6827fbbd46 100644
--- a/src/basic/label.c
+++ b/src/basic/label.c
@@ -5,26 +5,46 @@
 
 #include "label.h"
 
-static const LabelOps *label_ops = NULL;
+#define POSSIBLE_LABEL_OPS 2 /* SELinux and Smack */
 
-int label_ops_set(const LabelOps *ops) {
-        if (label_ops)
-                return -EBUSY;
+static const LabelOps *label_ops[POSSIBLE_LABEL_OPS];
 
-        label_ops = ops;
-        return 0;
+int label_ops_set(const LabelOps *ops) {
+        int i;
+
+        for (i = 0; i < POSSIBLE_LABEL_OPS; i++) {
+                if (!label_ops[i]) {
+                        label_ops[i] = ops;
+                        return 0;
+                }
+        }
+        return -EBUSY;
 }
 
 int label_ops_pre(int dir_fd, const char *path, mode_t mode) {
-        if (!label_ops || !label_ops->pre)
-                return 0;
-
-        return label_ops->pre(dir_fd, path, mode);
+        int i;
+        int r;
+
+        for (i = 0; i < POSSIBLE_LABEL_OPS; i++) {
+                if (label_ops[i] && label_ops[i]->pre) {
+                        r = label_ops[i]->pre(dir_fd, path, mode);
+                        if (r)
+                                return r;
+                }
+        }
+        return 0;
 }
 
 int label_ops_post(int dir_fd, const char *path) {
-        if (!label_ops || !label_ops->post)
-                return 0;
-
-        return label_ops->post(dir_fd, path);
+        int i;
+        int r;
+
+        for (i = 0; i < POSSIBLE_LABEL_OPS; i++) {
+                if (label_ops[i] && label_ops[i]->post) {
+                        r = label_ops[i]->post(dir_fd, path);
+                        if (r)
+                                return r;
+                }
+        }
+        return 0;
 }
diff --git a/src/core/smack-setup.c b/src/core/smack-setup.c
index bcaa237c8d..b1dbbbc2e8 100644
--- a/src/core/smack-setup.c
+++ b/src/core/smack-setup.c
@@ -319,7 +319,7 @@ int mac_smack_setup(bool *loaded_policy) {
         }
 
 #if HAVE_SMACK_RUN_LABEL
-        r = write_string_file("/proc/self/attr/current", SMACK_RUN_LABEL, WRITE_STRING_FILE_DISABLE_BUFFER);
+        r = write_string_file("/proc/self/attr/smack/current", SMACK_RUN_LABEL, WRITE_STRING_FILE_DISABLE_BUFFER);
         if (r < 0)
                 log_warning_errno(r, "Failed to set SMACK label \"" SMACK_RUN_LABEL "\" on self: %m");
         r = write_string_file("/sys/fs/smackfs/ambient", SMACK_RUN_LABEL, WRITE_STRING_FILE_DISABLE_BUFFER);
diff --git a/src/shared/label-util.c b/src/shared/label-util.c
index 3316c9ed37..3154818371 100644
--- a/src/shared/label-util.c
+++ b/src/shared/label-util.c
@@ -120,8 +120,6 @@ int btrfs_subvol_make_label(const char *path) {
 int mac_init(void) {
         int r;
 
-        assert(!(mac_selinux_use() && mac_smack_use()));
-
         r = mac_selinux_init();
         if (r < 0)
                 return r;
diff --git a/src/shared/smack-util.c b/src/shared/smack-util.c
index 1f88e724d0..5661428f96 100644
--- a/src/shared/smack-util.c
+++ b/src/shared/smack-util.c
@@ -112,7 +112,7 @@ int mac_smack_apply_pid(pid_t pid, const char *label) {
         if (!mac_smack_use())
                 return 0;
 
-        p = procfs_file_alloca(pid, "attr/current");
+        p = procfs_file_alloca(pid, "attr/smack/current");
         r = write_string_file(p, label, WRITE_STRING_FILE_DISABLE_BUFFER);
         if (r < 0)
                 return r;

