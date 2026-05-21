Received: from flow-a3-smtp.messagingengine.com (flow-a3-smtp.messagingengine.com [103.168.172.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646C9385D93;
	Thu, 21 May 2026 06:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779346702; cv=none; b=bvNQjYDmMN9jjpoW225ByxOCXJOW4Xm7XsBxUUcxROhNqOU0gAVkWijk0R/yZZiIBBAGc9PeaKv4wLpUNL7CGPaj8ZfzU9+BIX6z59ZCmbzCOqn1/1fu9ugPnn1YDEY9CXBcCt/V0gHrg0S9fvSqm93BeUZGSGTmLLZZ5Clbd30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779346702; c=relaxed/simple;
	bh=LNdNykvRPLHdfRVcmX0+iCj9WrM+E4PlicJ+dGsSA/c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PI1j7lBLWi235fGG3PGQoPs6jOPuJZBTi5rXN7L6KKBtiRi9A36Urqd7eKZn0cF6BAvFIzWP+g19WqraNibYUIIFs/4ZuMxv5WMD7ke+/PmEjAp3LKJTFrAIMnHT9eRxDntfAApdAWkYRnJ1zLiDp712s+Zrn8BJxk/WmKiG7Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eduardovasconcelos.com; spf=pass smtp.mailfrom=eduardovasconcelos.com; dkim=pass (2048-bit key) header.d=eduardovasconcelos.com header.i=@eduardovasconcelos.com header.b=YROikU3p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RBbvRLu2; arc=none smtp.client-ip=103.168.172.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eduardovasconcelos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eduardovasconcelos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=eduardovasconcelos.com header.i=@eduardovasconcelos.com header.b="YROikU3p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RBbvRLu2"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.phl.internal (Postfix) with ESMTP id EC35F138027F;
	Thu, 21 May 2026 02:58:17 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 21 May 2026 02:58:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	eduardovasconcelos.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to; s=fm1; t=
	1779346697; x=1779350297; bh=8KKk4OstiZD1mRxwYz1AQFEeysiHg2heUSn
	DHuC1LuA=; b=YROikU3pH27BEfuvHGZWQcua54t9lJ+0ejva5hp6j3rpacbrOQI
	nUBY/MPr3GbWB1K4lUR4AFfKWtFiIUdpGecqqlewxQYG64VkBCntq58AZZFLEUzO
	/w1DuKhKi+xrhk3uBPCdAmLgZg2n4Y48eIVP5jFYCdFsIoNNAxTfHZ8TOYRX5GyB
	f7Z9USQ/I0/0raYeM3KUGKG+aRhhUaImszwxif96kF0aX+qidt5Lpxs4LApdgpMz
	ONMcSVi+1/7bU79SiMIjntf/hadPbfX5kmsEt8a66UWzKQMbcsIUYuTPAPar4bF1
	L9rk1V5xDAyKKgF20U9dGlIB5C4i81fBC1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779346697; x=1779350297; bh=8KKk4OstiZD1mRxwYz1AQFEeysiHg2heUSn
	DHuC1LuA=; b=RBbvRLu2WNa2/BZb3XIg0Xtgigv5l84bG9GyQXthmqcGeI7bsQC
	tjz2nIiq/7T3sMK8uHqonOAE4ONuPPh3RZHahHSqfN2iMLrIp4ryhnnMKBHnYnkr
	MpF86arRkC6VRGbRe/HyBw8FYiD2bordRtehGJtSk1vA2fsMzNCdqa0Y82BxFzF8
	/gQuoV4zqzT+hk0hz2OW2O52T1UAeMUB/zQ7ENb94y2Fs8VHfHo+Qiw6n0obYmAi
	IeWC6gsCCZbEOuKBWMmrLRXMfPqrZbWqBpfvVhiLOwnNN4ykANWnAXJlRc0EaQpa
	+M1+a1NJsNurAA8SVr7kN1FNxGiwfUnYDLw==
X-ME-Sender: <xms:CK0OagdBpGDenSU-jKcodHXLgtGPJJN8Sq41vTflZTcOS52lymH12Q>
    <xme:CK0OauP3h52P7pf6vc2hdDLqsyh6kdqc1ujUSsAeWi_xvsJ7JsNyIJaJk7UvmmbbR
    sM5cJs5NokMdwkjc1A4zpJ2HF2D0l4XVWqVIPac-NQhX5h20FdMNiU>
X-ME-Received: <xmr:CK0OajvOoR25JvWNTt0eOXHu1msEhGP5YE43GwXkFgqS81mYdNzGp2o2R2YXXA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeeikeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpefgughurghrughoucggrghstghonhgtvghlohhsuceovgguuhgrrhgu
    ohesvgguuhgrrhguohhvrghstghonhgtvghlohhsrdgtohhmqeenucggtffrrghtthgvrh
    hnpedutdeuffehveeguddugeefffejveevueeggeejuedvleehgfekueejgffghfffueen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegvughurg
    hrughosegvughurghrughovhgrshgtohhntggvlhhoshdrtghomhdpnhgspghrtghpthht
    ohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhohhhnrdhjohhhrghnsh
    gvnhestggrnhhonhhitggrlhdrtghomhdprhgtphhtthhopehprghulhesphgruhhlqdhm
    ohhorhgvrdgtohhmpdhrtghpthhtohepjhhmohhrrhhishesnhgrmhgvihdrohhrghdprh
    gtphhtthhopehsvghrghgvsehhrghllhihnhdrtghomhdprhgtphhtthhopegvughurghr
    ughosegvughurghrughovhgrshgtohhntggvlhhoshdrtghomhdprhgtphhtthhopegrph
    hprghrmhhorheslhhishhtshdruhgsuhhnthhurdgtohhmpdhrtghpthhtoheplhhinhhu
    gidqshgvtghurhhithihqdhmohguuhhlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:CK0OanCxRXjwszm_Kx9GvCOVbVkRijYM8eD3-aC8l2nE9j-r9C757g>
    <xmx:CK0OaqYBdQ3n_v-A_iqtmW-9HH3QInlbE8Q3-Cq3pcwBKD89ujLiYw>
    <xmx:CK0OaiWN4WBhgzfSpM6dFN3FZFSN4zZ8RSD-qM3bZ_X7bSjqWP24IA>
    <xmx:CK0OapOGdJoQO0dRAdkaV7mOmcxDfTebHjcaqt6Ap_9Sq9ap8-Iwgg>
    <xmx:Ca0OajhlSpA3-u7jJ0hAKqBf8IPj2Sqon8iZ6G36UikUEtnVr5xYCusj>
Feedback-ID: iac1e4b6b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 May 2026 02:58:13 -0400 (EDT)
From: Eduardo Vasconcelos <eduardo@eduardovasconcelos.com>
To: john.johansen@canonical.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: Eduardo Vasconcelos <eduardo@eduardovasconcelos.com>,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] apparmor: Fix inverted comparison in cache_hold_inc()
Date: Thu, 21 May 2026 03:57:24 -0300
Message-ID: <20260521065731.6888-1-eduardo@eduardovasconcelos.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cache_hold_inc() prevents the per-CPU cache hold counter from
rising above MAX_HOLD_COUNT, but the comparison is inverted
(> MAX_HOLD_COUNT instead of <), so the counter never rises
above 0.

This breaks the cache mechanism because since the hold counter
is always 0, the global pool is always attempted first before
falling back to the local cache. The decrement also never occurs,
thus the hold counter is effectively dead.

Fix by changing > to < in cache_hold_inc().

Signed-off-by: Eduardo Vasconcelos <eduardo@eduardovasconcelos.com>
---
 security/apparmor/lsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 3491e9f60194..b7c19805a216 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -2129,7 +2129,7 @@ static int param_set_mode(const char *val, const struct kernel_param *kp)
  */
 static void cache_hold_inc(unsigned int *hold)
 {
-	if (*hold > MAX_HOLD_COUNT)
+	if (*hold < MAX_HOLD_COUNT)
 		(*hold)++;
 }
 
-- 
2.54.0

