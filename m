Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162EC3CCFAF
	for <linux-security-module@vger.kernel.org>; Mon, 31 Aug 2026 10:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788173945; cv=none; b=Zyo1oQYYmTDnIXP5KpvRazwwkT6K9Tc5dTfMZn5qW5yC4YKuzOyG+e8f1aLy0YNPxirxoaah6ZSMddDenQ7g4QD3y6K/lWI/Ya3BYDQlETQQqXlDV5OervYJZ12hrKTKEjRBRRrPBokFskAPIvaLagr+8l8Qu47WoPFkoPJl0gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788173945; c=relaxed/simple;
	bh=Nl/go5voN0tsV3KwMOJ4GQgVp3rsIzLKYsRdCy5p5JM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HRk1O/C29GpyT9rJsMmYw8GaCNVmPyCbtvrplgnrGaVj7Zq/nJ0Ja6IHH0OTgy1YP2UNIw4ufZOyWQAHQUA1Ri9zKDOgbzp8hhnnyeIPhboROHmJR/x4Oifcjn6YBHoTpPu9xNRdVvZ2VPlqt+ArFvDK90W40B0mQrJ+cjUfpFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eTE9XWQR; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTE9XWQR"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47f96c5b722so2051635f8f.0
        for <linux-security-module@vger.kernel.org>; Mon, 31 Aug 2026 03:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788173942; x=1788778742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=12zUrRkkhAoDFz8LTvcI9q2JnGLDYVplYhO4vSWaxZY=;
        b=eTE9XWQRSZucyV8tNWHnrC9fNycf+fV7qA/1mIc/Ka6M3rMnGWcPuo0SpoHDmfcK7Y
         VHASlwZOOYCzunJsB82P6qrea7/oPlTA1ewhAlDMbTHPyQNLPgekQ3j+bMxxo8/EgF1Q
         RIHj3/SaCvh4O6dI20pr3sI0qNanxcEDB9jRCBQ40HUmfHbV/tyqdr9XZz61++rtEgkj
         2UXNTETEBkRe9yKEI7nR7KI4GZsVrK7b1BXz/mCsWa7V0MxsnBAj0Kt32Jd04lDZCcPY
         oFn/4+m4i4PPb5GqGt0oGwNSwP9E1jTTUKVsWGD9uxUkbnjBraylWbnuCSZTW3Fqrs3U
         dxeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788173942; x=1788778742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=12zUrRkkhAoDFz8LTvcI9q2JnGLDYVplYhO4vSWaxZY=;
        b=ptKiQXx0H9T7uFlmi1qMgoz7FW75trrQjndQlck3lp9C2hY4JCPqMlclFnoH7hPUpr
         G+QwRfpHZ4TUtN0e/9zcYhMTVuKYf+jimc18ryZxAJH+4+dQhrhtXSQ/fOC9iSi8KiDS
         FRg6J0HlwXg6iByy78BQ0m5DYZulrktWMU+DJz1G9gTTQEtqP+mu+ktC+oQRm3z/pbIe
         uiEAXANg7hh8+jpPFXFiKT3UYCh/1R4QspNYDr8fP8ETPtuyUQnXqNPUMwhBb0IsoYtr
         EXqw+VWB16uwC2MHOFh8H3Vm3pKWXOps9vldDCKNN6YHzH7L5A/qc02RadAI4jPHZS/Y
         MEOQ==
X-Forwarded-Encrypted: i=1; AKwUvBxDiQitezuVq3popWOW9ocSN+Xx4FqOpd2uLlAFJS0J6m/mvk8+l9tNQT8W2lBair2BjkFe4+JUcPoI/i1EU7xXycy939s=@vger.kernel.org
X-Gm-Message-State: AFuF++l92vfBMHIFncRELz6GACvVPTP5dNFYSfIkf9xZ6ccw37atl03a
	0aNhOVq7AKijHBc5JeSD+E2ARibf6ms7AUw5Z4oy9MYAbkcXhYolm+1r
X-Gm-Gg: AYBFou2XXWB6iykgjjLfN/XLrMriTXCRWPH0z+X3n6oy3JH17x6TBBoephnI3C3Pq6q
	ZZ4RD0bAumTopmwknrojzMfkr0QxJU2v+aMMdlxZZLby2waayQG+5Id7bjKzSKJVVnr1V1XaQHG
	wDrg5+OoKgU1Rjg9lbYL6LgaItR3N0uSi7tFW40OL1uAWgkmleFdCGNzfX1s4ZdAsQvOvoH6XmW
	u2b5SKiR8rCMXySffCasVL5sx4A85vVB+BCNyN3gH59n6nC64zXAsmWdgnCYKHqT9KT9wcK8G0f
	NTZdcSCOC0wEE9GmCeYpAypr9yd8tjNEoBxyw/0754ufD0/ceNs21nFexkhN90bRgeeiQrjSlal
	lCnKFcYlJCYRUw0XEAdwGKco7nj43+hBeH245qKpCda5BiYH+8pkv7wpq/8MvDa6eS5p83PONiI
	OYagoEhZb/3HXJ/Ux7gqRYX5Q5WIWcTzOJqkmxeG1fz+kgAFZVFlNb2fqWwTqWvhVRETcZuTUki
	9n18A==
X-Received: by 2002:a05:6000:24c6:b0:47f:4919:d5b2 with SMTP id ffacd0b85a97d-482f79870bemr37568503f8f.1.1788173942064;
        Mon, 31 Aug 2026 03:59:02 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-484322ce2a6sm16110776f8f.19.2026.08.31.03.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 03:59:01 -0700 (PDT)
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
Subject: [PATCH bpf-next 2/7] net, bpf: Add a generic netlink hook on msg_rcv
Date: Mon, 31 Aug 2026 11:09:27 +0000
Message-ID: <20260831110934.241898-3-a.s.protopopov@gmail.com>
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

Add a new bpf_lsm_genl_family_rcv_msg() BPF hook called from within
the genl_family_rcv_msg() function. The hook sees the genl family,
net, cmd, and nlmsg_flags.  As the hook receives all the information
pre-parsed, it is not put into the sleepable list.

There is already an existing LSM hook sitting right at netlink_send,
however, it looks to be too coarse-grained to be used directly. The
netlink_send hook sees the struct sock and struct skb, and thus must
duplicate all the parsing inside BPF. The messages can actually contain
multiple netlink datagrams, dynamic info (see e.g., selinux_nlmsg_lookup()
in context of generic netlink), etc.

The purpose of this hook is to mitigate, in a coarse-grained way,
CVEs reachable via the corresponding control path: genl recvmsg.
While looking at the recent CVEs, robots found ~300 CVEs reachable
via the genl_rcv. We can roughly split them as follows:

  * Around 100 are ethtool-related. For more detailed information,
    see the following commit which adds even more finer-grained
    ethtool hooks.

  * Around 100 of the remaining are fully dominated by the new hook.

  * Around 100 remaining aren't fully mitigatable, as other control
    paths, besides the genl, lead to the buggy code.

To be more precise, the following CVEs are properly mitigated by the
new hook:

  * CVE-2021-47518 CVE-2021-47594 CVE-2021-47612 CVE-2022-48687
    CVE-2022-49060 CVE-2022-49085 CVE-2022-49300 CVE-2022-49862
    CVE-2022-49959 CVE-2022-50656 CVE-2022-50834 CVE-2022-50854
    CVE-2023-52698 CVE-2023-52702 CVE-2023-52977 CVE-2023-53113
    CVE-2023-53298 CVE-2023-53686 CVE-2023-53843 CVE-2024-26608
    CVE-2024-26663 CVE-2024-26754 CVE-2024-26811 CVE-2024-26950
    CVE-2024-27025 CVE-2024-27410 CVE-2024-36941 CVE-2024-38562
    CVE-2024-43912 CVE-2024-45010 CVE-2024-46711 CVE-2024-49937
    CVE-2024-50085 CVE-2025-21706 CVE-2025-21787 CVE-2025-21862
    CVE-2025-21875 CVE-2025-21947 CVE-2025-22024 CVE-2025-38184
    CVE-2025-38443 CVE-2025-40084 CVE-2025-68263 CVE-2025-68366
    CVE-2026-23297 CVE-2026-23436 CVE-2026-43252 CVE-2026-43394
    CVE-2026-53128 CVE-2026-53227 CVE-2026-53233 CVE-2026-53238
    CVE-2026-53257

The following are mitigated as well, but, theoretically, could
benefit from a finer-grained hook, running after a deeper
parsing/taking locks (this is however out of scope for now to
add finer-grained hooks for each involved subsystems, as, unlike
ethtool, they are more-or-less evenly distributed):

  * CVE-2021-47250 CVE-2021-47257 CVE-2021-47554 CVE-2022-48915
    CVE-2022-49374 CVE-2022-49505 CVE-2022-50042 CVE-2022-50678
    CVE-2023-52845 CVE-2023-53141 CVE-2023-53543 CVE-2023-53652
    CVE-2023-54031 CVE-2024-26725 CVE-2024-26951 CVE-2024-42073
    CVE-2024-42154 CVE-2024-46676 CVE-2024-47687 CVE-2024-50028
    CVE-2025-21973 CVE-2025-38020 CVE-2025-38628 CVE-2025-40254
    CVE-2025-40321 CVE-2025-68785 CVE-2025-71091 CVE-2025-71297
    CVE-2026-23321 CVE-2026-31707 CVE-2026-31744 CVE-2026-43012
    CVE-2026-43467 CVE-2026-43481 CVE-2026-45840 CVE-2026-52978
    CVE-2026-52979 CVE-2023-53570 CVE-2024-42114 CVE-2024-53189
    CVE-2024-56663 CVE-2025-21909 CVE-2026-53182

Policies for selected CVEs are added in the corresponding
selftests patch.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 include/linux/bpf_lsm.h           | 2 ++
 include/linux/bpf_lsm_hook_defs.h | 7 +++++++
 net/netlink/genetlink.c           | 6 ++++++
 3 files changed, 15 insertions(+)

diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
index 1e54c7cca27a..452b9d1d7c49 100644
--- a/include/linux/bpf_lsm.h
+++ b/include/linux/bpf_lsm.h
@@ -12,6 +12,8 @@
 #include <linux/bpf_verifier.h>
 #include <linux/lsm_hooks.h>
 
+struct genl_family; /* for the bpf_lsm_genl_family_rcv_msg hook */
+
 #ifdef CONFIG_BPF_LSM
 
 extern bool bpf_lsm_initialized __ro_after_init;
diff --git a/include/linux/bpf_lsm_hook_defs.h b/include/linux/bpf_lsm_hook_defs.h
index 29bc0b514d16..3f57022744a3 100644
--- a/include/linux/bpf_lsm_hook_defs.h
+++ b/include/linux/bpf_lsm_hook_defs.h
@@ -4,3 +4,10 @@
  * This is a set of BPF LSM hooks, which are _not_ fully implemented
  * as LSM hooks. Thus, they only can be used by BPF LSM programs.
  */
+
+#ifdef CONFIG_NET
+
+LSM_HOOK(int, 0, genl_family_rcv_msg, const struct genl_family *family,
+	 const struct net *net, u32 cmd, u16 nlmsg_flags)
+
+#endif /* CONFIG_NET */
diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
index 0da39eaed255..12b4f49c7253 100644
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -17,6 +17,7 @@
 #include <linux/skbuff.h>
 #include <linux/mutex.h>
 #include <linux/bitmap.h>
+#include <linux/bpf_lsm.h>
 #include <linux/rwsem.h>
 #include <linux/idr.h>
 #include <net/sock.h>
@@ -1161,6 +1162,7 @@ static int genl_family_rcv_msg(const struct genl_family *family,
 	struct genlmsghdr *hdr = nlmsg_data(nlh);
 	struct genl_split_ops op;
 	int hdrlen;
+	int err;
 	u8 flags;
 
 	/* this family doesn't exist in this netns */
@@ -1187,6 +1189,10 @@ static int genl_family_rcv_msg(const struct genl_family *family,
 	    !netlink_ns_capable(skb, net->user_ns, CAP_NET_ADMIN))
 		return -EPERM;
 
+	err = bpf_lsm_hook(genl_family_rcv_msg, family, net, hdr->cmd, nlh->nlmsg_flags);
+	if (err)
+		return err;
+
 	if (flags & GENL_CMD_CAP_DUMP)
 		return genl_family_rcv_msg_dumpit(family, skb, nlh, extack,
 						  &op, hdrlen, net);
-- 
2.43.0

