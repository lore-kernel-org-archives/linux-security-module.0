Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2BE1FBBC5
	for <linux-security-module@vger.kernel.org>; Mon, 13 Jan 2025 16:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736786398; cv=none; b=IOa7chSjRTL2CjbTuO/oxG48W8jxSYb8i8WbL4nS006KCMUizZgcF2ekapbsU9zN5nWeiPPoaDLwZ/u14DwfUt3Wf0xk+vQO8ow/4ikhc4yz/nVdiO54zk0f1qMbHQJiURd//ec2TK1/dkDXOYD1MG5E5SnIg2WBsx+4kJDSQXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736786398; c=relaxed/simple;
	bh=6U0fZiLclU/GxSD10ZX+ZSNjxettFMd+QmRMQdJG1vs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bjM51R4XTXw+oxZ76JxFoktbxdTKcrfyJLU95yqy4odWFcotQ5UgoW5QY5D1X/eEaYTMIIxREjTyPQDTzL3mtE3pBg/g6VQFZ3IZ+PS7CCSCkHdTgXcdYEL7oD6Mc3LjJ0WfAzVDm84G/OEKuezbJwESiLv5jiZSSJG3seZ+Yl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tXNTL-0001hI-Ks; Mon, 13 Jan 2025 17:39:27 +0100
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tXNTJ-000I5i-1m;
	Mon, 13 Jan 2025 17:39:26 +0100
Received: from localhost ([::1] helo=dude05.red.stw.pengutronix.de)
	by dude05.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tXNFq-007FQL-35;
	Mon, 13 Jan 2025 17:25:30 +0100
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
Date: Mon, 13 Jan 2025 17:25:37 +0100
Subject: [PATCH v2 12/12] reboot: retire hw_protection_reboot and
 hw_protection_shutdown helpers
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-hw_protection-reboot-v2-12-161d3fc734f0@pengutronix.de>
References: <20250113-hw_protection-reboot-v2-0-161d3fc734f0@pengutronix.de>
In-Reply-To: <20250113-hw_protection-reboot-v2-0-161d3fc734f0@pengutronix.de>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Fabio Estevam <festevam@denx.de>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
 Jonathan Corbet <corbet@lwn.net>, Serge Hallyn <serge@hallyn.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Matti Vaittinen <mazziesaccount@gmail.com>, 
 Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
 Guenter Roeck <groeck@chromium.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org, 
 chrome-platform@lists.linux.dev, devicetree@vger.kernel.org, 
 kernel@pengutronix.de, Ahmad Fatoum <a.fatoum@pengutronix.de>
X-Mailer: b4 0.14.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-security-module@vger.kernel.org

The hw_protection_reboot and hw_protection_shutdown functions mix
mechanism with policy: They let the driver requesting an emergency
action for hardware protection also decide how to deal with it.

This is inadequate in the general case as a driver reporting e.g. an
imminent power failure can't know whether a shutdown or a reboot would
be more appropriate for a given hardware platform.

With the addition of the hw_protection parameter, it's now possible to
configure at runtime the default emergency action and drivers are
expected to use hw_protection_trigger to have this parameter dictate
policy.

As no current users of either hw_protection_shutdown or
hw_protection_shutdown helpers remain, remove them, as not to tempt
driver authors to call them.

Existing users now either defer to hw_protection_trigger or call
__hw_protection_trigger with a suitable argument directly when
they have inside knowledge on whether a reboot or shutdown would
be more appropriate.

Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
 include/linux/reboot.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/include/linux/reboot.h b/include/linux/reboot.h
index 79e02876f2ba2b5508f6f26567cbcd5cbe97a277..aa08c3bbbf59a9dec65d775d280902b1455427c2 100644
--- a/include/linux/reboot.h
+++ b/include/linux/reboot.h
@@ -211,16 +211,6 @@ static inline void hw_protection_trigger(const char *reason, int ms_until_forced
 	__hw_protection_trigger(reason, ms_until_forced, HWPROT_ACT_DEFAULT);
 }
 
-static inline void hw_protection_reboot(const char *reason, int ms_until_forced)
-{
-	__hw_protection_trigger(reason, ms_until_forced, HWPROT_ACT_REBOOT);
-}
-
-static inline void hw_protection_shutdown(const char *reason, int ms_until_forced)
-{
-	__hw_protection_trigger(reason, ms_until_forced, HWPROT_ACT_SHUTDOWN);
-}
-
 /*
  * Emergency restart, callable from an interrupt handler.
  */

-- 
2.39.5

