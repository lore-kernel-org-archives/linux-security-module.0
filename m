Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABFF3D25A2
	for <linux-security-module@vger.kernel.org>; Mon, 31 Aug 2026 10:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788173947; cv=none; b=EZUcwt37semyepTU4/2KUdtCme7j1nbvX5ldAFGMRV6mLHQuzVoAILolwX7jHMFCpPAwy+fnyuyoVaMESUwugUbJPrL8B1kygc73+rju6YdyzWXQGaR9BkPX1xh79KQrJV7GgFmQuT5dhfFA4jeqU+DUc/nwwDrcJ9G6opNTvOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788173947; c=relaxed/simple;
	bh=ki4hkI/eoQZslyGePTiT7UOQt1CaCGEBh6h+BWNC+Tg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AUukhI0nVtwj5PG35JPKfcxzQTebcgDbEhjNPif9PJqUgzvhh5hyxIbpjO5HQxTTvtJXt8LQT6S6Bc3UJ5i1CfBTSg1bczYZjq5uXwEqDx71Y62QZRvi4PuFL6R4zPmNfWg6uD4Pe55fKa2Y15mV6NK3guvBV3FJef4nODRgTZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Loec0CbI; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Loec0CbI"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso26875935e9.0
        for <linux-security-module@vger.kernel.org>; Mon, 31 Aug 2026 03:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788173943; x=1788778743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k3qcUmWjff+s+Df1vOpP2TQ2DQmUVGoZutbqQulvv0Q=;
        b=Loec0CbIrD0gadEGQ6Gtkt3f8ZXy79Ga+oiWz06bE0HQBBxEovYvJ2/lvVOZo4RjJ1
         qiBD23Kv4KLMOOiHvpSK6kXzv6AqYM3kSxjY1EqlBxZyLRvl0GKb92fscgsIV3lPP9EV
         a/cZEOSJIskM26VdzUJnM5+9AHLQZeoppUWhnhZNiGbzqqQs9XK7RAjfzDgsf1XeXRuQ
         CstnyoJKCs/IJDAbHY7bD0Z+orCiBfHFrR6GHnvbRJOM3UGGIMia9lwqFs4T73AFgkt8
         YVOE0RKC5cZzRWjhlNRtVK8fXw6PeGztrIkgwzJETOwC2VtMle/X6xDby4Kh18X3Bhxq
         DDnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788173943; x=1788778743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=k3qcUmWjff+s+Df1vOpP2TQ2DQmUVGoZutbqQulvv0Q=;
        b=jepu6mo9vxwIChSaGv7Oprs+HDY6yy5VKwdgEE/tGgVb030zeWkTomdfa51r7Jh9pL
         ArdEEI8JLtf74VKv804SFlsyPhmfXItsLr50IFhpmbgptLXyBKhPfZQr/Qcx4PiYvuhI
         kw1jDwMfN1HlMjRiqHALb56bxb8E7rgcSm53jPr9ftZKVrxwOHrh3uJa3MnmGQY5qipd
         TCymoT5aUEBRP9ABFcTmzx91zfslaC+JflfqM1K7FIQXe8gQPUpCp4hBqM9Egf7AH7au
         T+RwU30PgvJKif0m/z8qJSDNkaPzUeaoIf2r92ol++5rAwjEabpPsL69V5D18RXap9LO
         Mtrg==
X-Forwarded-Encrypted: i=1; AHgh+Ro+ElNo7AYmrJgUK0xizVnFclCfVgltZOMUSKaeLtGkpJgoUbbGWJFtJBtVChwjlwb8e1H+wXWKsJB3WNAvPv2M1mtcpAk=@vger.kernel.org
X-Gm-Message-State: AFuF++lTgNYmh7IGu3WwNM+9Z7TLuPe+rBIuJYZ+5+MeMPRFSWYJ8FW1
	0fYNT09eTqdcL/0KHa7HC+cI1mXeLKxMUlzR6yowKU8+WKMdPP3J9Iji
X-Gm-Gg: AR+sD13IToM78RVlTZeOUvbpbs/XkDprpL1reUgDL6QBhTodDfnY30TtUbcuPz5KYD/
	9gMZw5MrpphI6H+pacIs4Wyrn4irNVPVMyJDNBNiNR4ifVAj/7s7tirNtpXP5FHmkIVcPZUzBkC
	P4sdHfdiyvOG7Oq0d+upmYjRTByLlvw1cDpkG3d6wkkR+CokaJZaDEBDiEanFlYcdFCW7z4wQYc
	sTadtWUGGQg373qxws0QraTKmuUu56Leln4srvILFdOhbfSOrSa/sSHDQkUCW2toqv3sX07akmv
	8bojmAJRGmdlZsgU+fpntZNpVBBrLWVw38tnFnNnikhnapib0YrkaTgacNz9/U/mr0CqcFecASu
	x1/LzjK+rmTst9cEpQZ4AA7+rxRlbNHLuiJlMZ/+EvNOZqm9prjDcd49hiJ+W2HVFK01/y3qa91
	JnPOERjKgpORWadePC1E8sw3+D6PcJhCzP1/FBeIw0DxisCTAhOAIENlVbMBsWvlrQlrABVqF5W
	Velrw==
X-Received: by 2002:a05:600c:4691:b0:49c:d8f1:ec60 with SMTP id 5b1f17b1804b1-49cd8f1ecf7mr32079115e9.8.1788173943222;
        Mon, 31 Aug 2026 03:59:03 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-484322ce2a6sm16110776f8f.19.2026.08.31.03.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 03:59:02 -0700 (PDT)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf <bpf@vger.kernel.org>,
	lsm <linux-security-module@vger.kernel.org>,
	netdev <netdev@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <matt@bobrowski.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH bpf-next 3/7] net, bpf: Add bpf hooks for ethtool control path
Date: Mon, 31 Aug 2026 11:09:28 +0000
Message-ID: <20260831110934.241898-4-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831110934.241898-1-a.s.protopopov@gmail.com>
References: <20260831110934.241898-1-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds BPF hooks to enable runtime mitigation of bugs
caused, directly or indirectly, by running a specific ethtool
configuration/dump path. The bigger part of the patch adds
netlink-related hooks, and a small, trivial, part adds a hook
in the ioctl path.

The hooks added in this patch are "coarse-grained", which means here
that they only receive high-level info. Each hook is invoked with the
locking (RTNL and/or device), which is required to mitigate some of
CVEs, for example those, which need to consider the device state,
etc.  However, for some cases (like flash update), the actual
operation runs without locking, so only "stateless" policies are
applicable.

If a bug lies in the parsing done before locking, then the previously
added generic netlink hook can be used to prevent this bug.

Overall, this patch allows to mitigate [prevent] biger chunk of the
CVEs caused by the ethtool control path. Exceptions are CVEs which
can be triggered via ethtool_ops via sysfs or directly by kernel,
see the comments below.

The hooks are added to bpf_lsm_hook_defs.h and are as follows:

    ethtool_ioctl(const struct net_device *dev, u32 cmd, u32 sub_cmd)
    ethtool_netlink_doit(const struct net_device *dev, u32 cmd, u32 phy_index)
    ethtool_netlink_dump(const struct net_device *dev, u32 cmd, u32 phy_index)

Hooks aren't added to sleepable list: they receive all the infa,
plus run under a lock.

Another small note is that for a dump request a hook can be executed
multiple times: on sendto and on consequent recvfrom[s]. One
consequence on properly policing dump requests is that if a netlink
socket is shared, then dump hooks for a particular dump request can
run from within different cgroups and checked accordingly.

To validate that this actually makes sense to add these hooks, the
set of known CVEs was analysed and it was found that the following
CVEs could have been mitigated by these hooks:

  * ioctl-only: CVE-2021-46916 CVE-2021-46947 CVE-2021-47148
    CVE-2021-47556 CVE-2022-48688 CVE-2022-49725 CVE-2022-49581
    CVE-2022-49368 CVE-2023-52780 CVE-2023-53509 CVE-2023-53661
    CVE-2023-53798 CVE-2023-53142 CVE-2023-53495 CVE-2023-54240
    CVE-2024-40928 CVE-2024-42162 CVE-2025-21650 CVE-2025-37911
    CVE-2025-38422 CVE-2025-39875 CVE-2025-68795 CVE-2026-23353
    CVE-2026-31494 CVE-2026-31505 CVE-2026-31727 CVE-2026-23024

  * only doit: CVE-2025-21921 CVE-2024-43836 CVE-2025-37791

  * only dump: CVE-2022-50651

  * more than one hook required: CVE-2021-47159 CVE-2021-47241
    CVE-2021-47517 CVE-2021-47399 CVE-2021-47139 CVE-2022-49096
    CVE-2022-49227 CVE-2022-49869 CVE-2022-50003 CVE-2022-50710
    CVE-2022-49192 CVE-2023-53659 CVE-2023-54037 CVE-2023-53556
    CVE-2024-39502 CVE-2024-46834 CVE-2024-46770 CVE-2024-56728
    CVE-2024-46799 CVE-2025-21799 CVE-2025-71137 CVE-2025-38402
    CVE-2025-39922 CVE-2025-21701 CVE-2025-38735 CVE-2025-39874
    CVE-2025-40255 CVE-2026-22985 CVE-2026-23054 CVE-2026-23389
    CVE-2026-45891 CVE-2026-53007 CVE-2026-22993 CVE-2026-23165
    CVE-2026-53323

As was mentioned before, some ethtool_ops-related CVEs can't be
mitigated by the new hooks, as they are executed via other channels.
Around 30 of such were found. Examples are:

  * CVE-2022-50054, CVE-2024-46679, CVE-2024-50274

The CVEs listed above were first extracted and classifed by AI
robots, and then re-classified until different agents were in
99% agreement. Selected policies were hand-picked and added as
selftests in the corresponding patch.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 include/linux/bpf_lsm_hook_defs.h |  5 +++++
 net/ethtool/cabletest.c           |  6 ++++++
 net/ethtool/features.c            |  3 +++
 net/ethtool/ioctl.c               |  5 +++++
 net/ethtool/module.c              |  3 +++
 net/ethtool/netlink.c             | 17 ++++++++++++++---
 net/ethtool/netlink.h             | 25 +++++++++++++++++++++++++
 net/ethtool/rss.c                 | 10 ++++++++++
 net/ethtool/tsinfo.c              | 13 +++++++++++++
 net/ethtool/tunnels.c             | 14 ++++++++++++++
 10 files changed, 98 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf_lsm_hook_defs.h b/include/linux/bpf_lsm_hook_defs.h
index 3f57022744a3..a7f84756946e 100644
--- a/include/linux/bpf_lsm_hook_defs.h
+++ b/include/linux/bpf_lsm_hook_defs.h
@@ -10,4 +10,9 @@
 LSM_HOOK(int, 0, genl_family_rcv_msg, const struct genl_family *family,
 	 const struct net *net, u32 cmd, u16 nlmsg_flags)
 
+LSM_HOOK(int, 0, ethtool_ioctl, const struct net_device *dev, u32 cmd, u32 sub_cmd)
+LSM_HOOK(int, 0, ethtool_netlink_doit, const struct net_device *dev__nullable, u32 cmd,
+	 u32 phy_index)
+LSM_HOOK(int, 0, ethtool_netlink_dump, const struct net_device *dev, u32 cmd, u32 phy_index)
+
 #endif /* CONFIG_NET */
diff --git a/net/ethtool/cabletest.c b/net/ethtool/cabletest.c
index 9c22d4c767c6..dc846146bd2e 100644
--- a/net/ethtool/cabletest.c
+++ b/net/ethtool/cabletest.c
@@ -74,6 +74,9 @@ int ethnl_act_cable_test(struct sk_buff *skb, struct genl_info *info)
 	dev = req_info.dev;
 
 	netdev_lock_ops_compat(dev);
+	ret = ethnl_bpf_lsm_doit(&req_info, info->genlhdr->cmd);
+	if (ret)
+		goto out_unlock;
 	phydev = ethnl_req_get_phydev(&req_info, tb,
 				      ETHTOOL_A_CABLE_TEST_HEADER,
 				      info->extack);
@@ -341,6 +344,9 @@ int ethnl_act_cable_test_tdr(struct sk_buff *skb, struct genl_info *info)
 		goto out_dev_put;
 
 	netdev_lock_ops_compat(dev);
+	ret = ethnl_bpf_lsm_doit(&req_info, info->genlhdr->cmd);
+	if (ret)
+		goto out_unlock;
 	phydev = ethnl_req_get_phydev(&req_info, tb,
 				      ETHTOOL_A_CABLE_TEST_TDR_HEADER,
 				      info->extack);
diff --git a/net/ethtool/features.c b/net/ethtool/features.c
index d9455b30aec9..2aff2aa171f2 100644
--- a/net/ethtool/features.c
+++ b/net/ethtool/features.c
@@ -237,6 +237,9 @@ int ethnl_set_features(struct sk_buff *skb, struct genl_info *info)
 
 	rtnl_lock();
 	netdev_lock_ops(dev);
+	ret = ethnl_bpf_lsm_doit(&req_info, info->genlhdr->cmd);
+	if (ret)
+		goto out_unlock;
 	ret = ethnl_ops_begin(dev);
 	if (ret < 0)
 		goto out_unlock;
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 4b0bc503f930..16b02a7abb2c 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/compat.h>
+#include <linux/bpf_lsm.h>
 #include <linux/etherdevice.h>
 #include <linux/module.h>
 #include <linux/types.h>
@@ -3330,6 +3331,10 @@ dev_ethtool_locked(struct net *net, struct net_device *dev,
 
 	netdev_assert_locked_ops_compat(dev);
 
+	rc = bpf_lsm_hook(ethtool_ioctl, dev, ethcmd, sub_cmd);
+	if (rc)
+		return rc;
+
 	if (dev->dev.parent)
 		pm_runtime_get_sync(dev->dev.parent);
 
diff --git a/net/ethtool/module.c b/net/ethtool/module.c
index 9cf670e089f2..b316b465b953 100644
--- a/net/ethtool/module.c
+++ b/net/ethtool/module.c
@@ -430,6 +430,9 @@ int ethnl_act_module_fw_flash(struct sk_buff *skb, struct genl_info *info)
 	dev = req_info.dev;
 
 	netdev_lock_ops_compat(dev);
+	ret = ethnl_bpf_lsm_doit(&req_info, info->genlhdr->cmd);
+	if (ret)
+		goto out_unlock;
 	ret = ethnl_ops_begin(dev);
 	if (ret < 0)
 		goto out_unlock;
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 1af395b54330..80c8bde50f53 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -543,7 +543,9 @@ static int ethnl_default_doit(struct sk_buff *skb, struct genl_info *info)
 			rtnl_lock();
 		netdev_lock_ops(req_info->dev);
 	}
-	ret = ops->prepare_data(req_info, reply_data, info);
+	ret = ethnl_bpf_lsm_doit(req_info, cmd);
+	if (!ret)
+		ret = ops->prepare_data(req_info, reply_data, info);
 	if (req_info->dev) {
 		netdev_unlock_ops(req_info->dev);
 		if (need_rtnl)
@@ -595,6 +597,7 @@ static int ethnl_default_dump_one(struct sk_buff *skb, struct net_device *dev,
 				  const struct ethnl_dump_ctx *ctx,
 				  const struct genl_info *info)
 {
+	int cmd = ctx->ops->request_cmd;
 	bool need_rtnl;
 	void *ehdr;
 	int ret;
@@ -607,11 +610,15 @@ static int ethnl_default_dump_one(struct sk_buff *skb, struct net_device *dev,
 
 	ethnl_init_reply_data(ctx->reply_data, ctx->ops, dev);
 	need_rtnl = !netdev_need_ops_lock(dev) ||
-		    ethtool_nl_msg_needs_rtnl(dev, ctx->ops->request_cmd);
+		    ethtool_nl_msg_needs_rtnl(dev, cmd);
 	if (need_rtnl)
 		rtnl_lock();
 	netdev_lock_ops(dev);
-	ret = ctx->ops->prepare_data(ctx->req_info, ctx->reply_data, info);
+
+	ret = ethnl_bpf_lsm_dump(dev, ctx->req_info->phy_index, cmd);
+	if (!ret)
+		ret = ctx->ops->prepare_data(ctx->req_info, ctx->reply_data, info);
+
 	netdev_unlock_ops(dev);
 	if (need_rtnl)
 		rtnl_unlock();
@@ -934,6 +941,9 @@ static int ethnl_default_set_doit(struct sk_buff *skb, struct genl_info *info)
 	if (need_rtnl)
 		rtnl_lock();
 	netdev_lock_ops(dev);
+	ret = ethnl_bpf_lsm_doit(req_info, cmd);
+	if (ret)
+		goto out_unlock;
 	dev->cfg_pending = kmemdup(dev->cfg, sizeof(*dev->cfg),
 				   GFP_KERNEL_ACCOUNT);
 	if (!dev->cfg_pending) {
@@ -961,6 +971,7 @@ static int ethnl_default_set_doit(struct sk_buff *skb, struct genl_info *info)
 	kfree(dev->cfg_pending);
 out_tie_cfg:
 	dev->cfg_pending = dev->cfg;
+out_unlock:
 	netdev_unlock_ops(dev);
 	if (need_rtnl)
 		rtnl_unlock();
diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index 3e969a070f9f..30c56942149c 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -5,6 +5,7 @@
 
 #include <linux/ethtool_netlink.h>
 #include <linux/netdevice.h>
+#include <linux/bpf_lsm.h>
 #include <net/genetlink.h>
 #include <net/sock.h>
 
@@ -354,6 +355,30 @@ struct ethnl_sock_priv {
 int ethnl_sock_priv_set(struct sk_buff *skb, struct net *net, u32 portid,
 			enum ethnl_sock_type type);
 
+static inline int ethnl_bpf_lsm_doit(const struct ethnl_req_info *req_info, u32 cmd)
+{
+	return bpf_lsm_hook(ethtool_netlink_doit, req_info->dev, cmd, req_info->phy_index);
+}
+
+static inline int ethnl_bpf_lsm_dump(const struct net_device *dev,
+				     u32 phy_index,
+				     u32 cmd)
+{
+	int ret;
+
+	ret = bpf_lsm_hook(ethtool_netlink_dump, dev, cmd, phy_index);
+
+	/*
+	 * For a BPF policy this doesn't make any sense to return -EOPNOTSUPP.
+	 * But if it does, it will not be treated as an error by ethtool code,
+	 * so patch it here.
+	 */
+	if (ret == -EOPNOTSUPP)
+		ret = -EPERM;
+
+	return ret;
+}
+
 /**
  * struct ethnl_request_ops - unified handling of GET and SET requests
  * @request_cmd:      command id for request (GET)
diff --git a/net/ethtool/rss.c b/net/ethtool/rss.c
index d4a1a4724b67..d10bf701c336 100644
--- a/net/ethtool/rss.c
+++ b/net/ethtool/rss.c
@@ -475,6 +475,10 @@ int ethnl_rss_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 		if (ctx->match_ifindex && ctx->match_ifindex != ctx->ifindex)
 			break;
 
+		ret = ethnl_bpf_lsm_dump(dev, 0, ETHTOOL_MSG_RSS_GET);
+		if (ret)
+			break;
+
 		ret = rss_dump_one_dev(skb, cb, dev);
 		if (ret)
 			break;
@@ -1035,6 +1039,9 @@ int ethnl_rss_create_doit(struct sk_buff *skb, struct genl_info *info)
 		goto exit_free_dev;
 
 	netdev_lock_ops_compat(dev);
+	ret = ethnl_bpf_lsm_doit(&req.base, info->genlhdr->cmd);
+	if (ret)
+		goto exit_dev_unlock;
 
 	ret = ethnl_ops_begin(dev);
 	if (ret < 0)
@@ -1176,6 +1183,9 @@ int ethnl_rss_delete_doit(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	netdev_lock_ops_compat(dev);
+	ret = ethnl_bpf_lsm_doit(&req, info->genlhdr->cmd);
+	if (ret)
+		goto exit_dev_unlock;
 
 	ret = ethnl_ops_begin(dev);
 	if (ret < 0)
diff --git a/net/ethtool/tsinfo.c b/net/ethtool/tsinfo.c
index c9b680a9cc3f..d6131780f2df 100644
--- a/net/ethtool/tsinfo.c
+++ b/net/ethtool/tsinfo.c
@@ -352,6 +352,10 @@ static int ethnl_tsinfo_dump_one_phydev(struct sk_buff *skb,
 					struct netlink_callback *cb)
 {
 	struct ethnl_tsinfo_dump_ctx *ctx = (void *)cb->ctx;
+	struct ethnl_req_info hook_req_info = {
+		.dev = dev,
+		.phy_index = phydev->phyindex,
+	};
 	struct tsinfo_reply_data *reply_data;
 	struct tsinfo_req_info *req_info;
 	void *ehdr = NULL;
@@ -362,6 +366,11 @@ static int ethnl_tsinfo_dump_one_phydev(struct sk_buff *skb,
 
 	reply_data = ctx->reply_data;
 	req_info = ctx->req_info;
+	ret = ethnl_bpf_lsm_dump(dev, hook_req_info.phy_index,
+				 ETHTOOL_MSG_TSINFO_GET);
+	if (ret)
+		return ret;
+
 	ehdr = ethnl_tsinfo_prepare_dump(skb, dev, reply_data, cb);
 	if (IS_ERR(ehdr))
 		return PTR_ERR(ehdr);
@@ -401,6 +410,10 @@ static int ethnl_tsinfo_dump_one_netdev(struct sk_buff *skb,
 
 	reply_data = ctx->reply_data;
 	req_info = ctx->req_info;
+	ret = ethnl_bpf_lsm_dump(dev, 0, ETHTOOL_MSG_TSINFO_GET);
+	if (ret)
+		return ret;
+
 	for (; ctx->pos_phcqualifier < HWTSTAMP_PROVIDER_QUALIFIER_CNT;
 	     ctx->pos_phcqualifier++) {
 		if (!net_support_hwtstamp_qualifier(dev,
diff --git a/net/ethtool/tunnels.c b/net/ethtool/tunnels.c
index b4ce47dd2aa6..3d2798e716e0 100644
--- a/net/ethtool/tunnels.c
+++ b/net/ethtool/tunnels.c
@@ -179,6 +179,13 @@ int ethnl_tunnel_info_doit(struct sk_buff *skb, struct genl_info *info)
 		return ret;
 
 	rtnl_lock();
+
+	netdev_lock_ops(req_info.dev);
+	ret = ethnl_bpf_lsm_doit(&req_info, info->genlhdr->cmd);
+	netdev_unlock_ops(req_info.dev);
+	if (ret)
+		goto err_unlock_rtnl;
+
 	ret = ethnl_tunnel_info_reply_size(&req_info, info->extack);
 	if (ret < 0)
 		goto err_unlock_rtnl;
@@ -248,6 +255,13 @@ int ethnl_tunnel_info_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 
 	rtnl_lock();
 	for_each_netdev_dump(net, dev, ctx->ifindex) {
+		netdev_lock_ops(dev);
+		ret = ethnl_bpf_lsm_dump(dev, ctx->req_info.phy_index,
+					 ETHTOOL_MSG_TUNNEL_INFO_GET);
+		netdev_unlock_ops(dev);
+		if (ret)
+			break;
+
 		ehdr = ethnl_dump_put(skb, cb,
 				      ETHTOOL_MSG_TUNNEL_INFO_GET_REPLY);
 		if (!ehdr) {
-- 
2.43.0

