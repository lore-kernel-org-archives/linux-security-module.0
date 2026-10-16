Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFB14E36CB
	for <linux-security-module@vger.kernel.org>; Fri, 16 Oct 2026 14:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792161476; cv=none; b=EYDdiz+NtvBBXcpgEC6raM/gNS0fYu8XkOwhf2h/ZO4p4iMI84rYqHP4MouI9PSiZJST6hKKPZ+9/IifnI2JXXgxSFyBlq1kINmK9Q6W97x/Ve2DULw1Tum6vCwbjrgmkPBVb4y2Dx0rt8hXchc4uJlZ6mYl6sAwNGJr8ZYGWOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792161476; c=relaxed/simple;
	bh=wAp7afOfTC8HUwyazn0LOftlGcbyrbQpAQhvKDn+ea4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=b50VVyWd7hroScAi+I3fJtvIxtj+O+07ziWWSXdVdDUglkSpUvxWYq668Iw/3FSH9uNSufXgbpJU3Rb7qWuHqS6tTB6OgihpAyB6Q5qw507cfBxjcXqisC4T0mfWzGK6M5HGyUDKEuauNwC/7dgf3EHL46h6s2RObXrrp8WSS68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UL3b9nrb; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UL3b9nrb"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-9908e3cd939so429241.3
        for <linux-security-module@vger.kernel.org>; Fri, 16 Oct 2026 07:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792161469; x=1792766269; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OvFMfxSzYVJ2lOTMgtJEulD+6aZKmETG2qDahrWDVzI=;
        b=UL3b9nrbT8FhDYiBNNTYMQ0g2P11ovzC/D+iI3qA4y96nANAG1iq0ojqMX+/39b0y/
         9yPzrDqw4LCorPMdnBZ9IQyzBRf37IGvuAMPhixVqu2Cf6AIYaM6N6yi4mLyNHM+9VMI
         JlQ+rI+YpN66ADhcxVN2SK+ONvAoPnuE0mHLJ76SUoSfQm0k4m4zpOwb0C6uNhN9RzQF
         K7CINHUyZFay7mfeADRsrvzs6YwLdwPYcdN5/dc+C9jet4vXdYSPXG3w91NqCgmUXFFV
         lnnwxThvbmRG12eP9WCBod6Xn1fTqDS4F2wmXoJ25pvJMvj0PmO3kyXsdJMVzaTTOvOm
         a4Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792161469; x=1792766269;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OvFMfxSzYVJ2lOTMgtJEulD+6aZKmETG2qDahrWDVzI=;
        b=u7iewPXgLzUfS+GMsOJ4QGT8QzC5XMCOhyEky4PzJ2iElSlFBMqMxWGtNR319UFFgF
         D3n7QNxjPZPngMqUNYN6wBq0hPCkL6rbC3Q8+0Y+HbsHb6jAO+r+IWJsas/IyR/eVcJE
         I7kzqI5kCq3ty88dFgOtr2uh/fDd+Pyo5yMIJ2hqo2Y7l6XxaHCPYZ792g6noGBSpzjD
         jyNCBCeTNQaVu1TLCQ31XGEam7sKc6rT9IQh/HC1i40vtyRee0tamJJ9ZEGtqX9Ombq5
         lqDo7isvXuaemizFgA3lonezDQMKVkjVFXY0Gyj1Qq3xdAU0IaYb/kP886URQJ7Btw6F
         nQ9g==
X-Forwarded-Encrypted: i=1; AKwUvBxooL+zXvgeq75QTZgBe7wDkxRzR06JGvuvqnf5SF5+K9j/jQ+nDgsNnP6KpaXA4TcsFY8Bq43K0TeF+bgg0TQ39uMi4fg=@vger.kernel.org
X-Gm-Message-State: AFq9FYI9B5l8PtaFTdXe9bzZ+2jH21kN5ZbvbfanXDwQ0I7Jkqjf3j7e
	cf4SS8fwAuiumGXtMwNqxjbR2/JlOCwbb8c1fp0Gl7jBW/3uZdOTwlFb
X-Gm-Gg: AYBFou1f2l5URBVEDhWtXp0lSCIgP04yZ1H8tNBYx9Bt7OgNxOabPziCC1JvnwqG2wR
	i4kQoH4qUnoobYGWlmH78dh7mM3MfOzlK8xddEBMoME2hd6Ut9+mD6oDGF0O5FaC3a2t7u1xr52
	oQIvZph0vciq3Z3mXoDfeO0oGL7JAot/YLxtKun63tvC/Yd1w7VFXC9RQMwv97QD3zPoyctLcxq
	0TIokS5JMALY+AEXSivPpmeFkxU7DTAepQByxhlx0o+Q4Z2gri1jAqy53/Fm9KOSOaC1sQ33AV0
	uXKPV9zMPdvzbKVKBKrtYdRfgkVEbXcXGU50tJ8oVN3KSntZpu4UH8ZrH+qatllLLecaj3yhoqb
	u4TcHIC28FfGytPcCwv+a0JdbRDblHZOXcvR6GJ2tX6+os5VdFbckyyPZ40Sefu+QguOCWcChuX
	K/bVIL7KzXDAFggv7AkmgeNoHA3G7xEdFlXFVuGmlI+tFVxKmVeVOgT3NlNuLWwSt4EHMY8kWEt
	9ffFIGLB+aKBHAvJDnLSN15HJojia0+o4lEfVgq0v8Jx81okhuSFVLxjLvMrDXwrKra2ztqhNPz
	zVODKi5eztPefooNvzYsPBtDaij75+ndAnNZQC1CacnO241VLq7+lwgh
X-Received: by 2002:a05:6102:c48:b0:7c8:3b8c:82ba with SMTP id ada2fe7eead31-7cb373de301mr5673762137.32.1792161468460;
        Fri, 16 Oct 2026 07:37:48 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2804:7f0:b100:ece0:b5:bb23:a54:ce61])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7cc1983af93sm2248453137.8.2026.10.16.07.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 07:37:47 -0700 (PDT)
From: Joas Antonio dos Santos <joasantonio108@gmail.com>
To: Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Ondrej Mosnacek <omosnacek@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>,
 Phil Sutter <phil@nwl.cc>, selinux@vger.kernel.org,
 linux-security-module@vger.kernel.org, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selinux: don't label bridged packets in selinux_ip_forward()
Date: Fri, 16 Oct 2026 11:37:41 -0300
Message-ID: <179216146138.25460.7866279004288174372@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

With br_netfilter and bridge-nf-call-ip{,6}tables enabled, bridged IP
packets go through the NF_INET_FORWARD hook, where selinux_ip_forward()
calls selinux_netlbl_skbuff_setsid() and NetLabel may add or remove a
CIPSO or CALIPSO option.  cipso_v4_skbuff_setattr(),
calipso_skbuff_setattr() and calipso_skbuff_delattr() move the IP
header and reset the network header, but the Ethernet header stays
where it was; when the bridge pushes it back in front of the packet it
picks up stale bytes and the frame goes out with a garbage destination
MAC and EtherType.

Labeling a bridged packet based on its IP addresses is not what we want
here anyway, so leave bridged packets alone.  Add a stub of
nf_bridge_info_exists() for CONFIG_BRIDGE_NETFILTER=n.

Tested with QEMU, two veths enslaved to a bridge with br_netfilter in
the middle, SELinux and a NetLabel DOI 16 configuration, 5 UDP packets
per case:

  case                                        before        after
  CALIPSO packet, unlabeled destination       MAC garbage   5/5
  unlabeled IPv6, CALIPSO destination         MAC garbage   5/5
  unlabeled IPv4, CIPSO destination           MAC garbage   5/5

Routed packets are still labeled (an unlabeled packet forwarded towards
a CALIPSO destination gets the option, 5/5).

Fixes: 948bf85c1bc9 ("netlabel: Add functionality to set the security attributes of a packet")
Link: https://lore.kernel.org/netdev/CAHC9VhS+bdL_YnLQtd0sPmKKfy9BvS-LWV_6EhAuu4qfUFe_mw@mail.gmail.com/
Suggested-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
Assisted-by: Claude:claude-opus-5-5
---
 include/linux/netfilter_bridge.h |  5 +++++
 security/selinux/hooks.c         | 13 ++++++++-----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/include/linux/netfilter_bridge.h b/include/linux/netfilter_bridge.h
index 743475ca7..c1f7c3cb2 100644
--- a/include/linux/netfilter_bridge.h
+++ b/include/linux/netfilter_bridge.h
@@ -79,6 +79,11 @@ static inline bool nf_bridge_in_prerouting(const struct sk_buff *skb)
 }
 #else
 #define br_drop_fake_rtable(skb)	        do { } while (0)
+static inline bool nf_bridge_info_exists(const struct sk_buff *skb)
+{
+	return false;
+}
+
 static inline bool nf_bridge_in_prerouting(const struct sk_buff *skb)
 {
 	return false;
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 30776b010..1e4f02f99 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -49,6 +49,7 @@
 #include <linux/fs_parser.h>
 #include <linux/netfilter_ipv4.h>
 #include <linux/netfilter_ipv6.h>
+#include <linux/netfilter_bridge.h>
 #include <linux/tty.h>
 #include <net/icmp.h>
 #include <net/ip.h>		/* for local_port_range[] */
@@ -6145,11 +6146,13 @@ static unsigned int selinux_ip_forward(void *priv, struct sk_buff *skb,
 				 SECCLASS_PACKET, PACKET__FORWARD_IN, &ad))
 			return NF_DROP;
 
-	if (netlbl_enabled())
-		/* we do this in the FORWARD path and not the POST_ROUTING
-		 * path because we want to make sure we apply the necessary
-		 * labeling before IPsec is applied so we can leverage AH
-		 * protection */
+	/* we do this in the FORWARD path and not the POST_ROUTING path
+	 * because we want to make sure we apply the necessary labeling
+	 * before IPsec is applied so we can leverage AH protection; bridged
+	 * packets are skipped as changing their IP options would leave the
+	 * Ethernet header behind
+	 */
+	if (netlbl_enabled() && !nf_bridge_info_exists(skb))
 		if (selinux_netlbl_skbuff_setsid(skb, family, peer_sid) != 0)
 			return NF_DROP;
 
-- 
2.43.0

