Received: from blizzard.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7223C152160;
	Mon, 26 Aug 2024 10:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724669401; cv=none; b=aFjKIYjde8Y4jZSo+krpncui0bd3fGHboPvvxlfgDPTICJ4WY2AbPha5NnvgqYH6kcLyf1AGmQkt0z3AaJ+BhDl08iycF3g3vaZ0GSXcHuo08546z2pGJb7jSFAbJhOA1szk7zdogzc0gJVH20tphECl8weYCsrjgRDOLigMHkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724669401; c=relaxed/simple;
	bh=H1sKbPQmQY8ikHWY6DyWg8kD7vsi9dQ7844hbzNVmHo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j6hsOKbKRhHDA0fDyK9hcitRvvvxCPKIyM6SgZZCOrOs8oiHbWBXQWj6EggR+U72GguaJdoyol9petI55kfE9JvqlmfiP8Qvk7VrLl5Dbul5dZbCZxUsr+jT6faJZ8FbtKhv56h0WJrfXqaf5XKn9O4oPh/at1jhLYSNyladIKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjellic.com
Received: from blizzard.enjellic.com (localhost [127.0.0.1])
	by blizzard.enjellic.com (8.15.2/8.15.2) with ESMTP id 47QAbVZa003449;
	Mon, 26 Aug 2024 05:37:31 -0500
Received: (from greg@localhost)
	by blizzard.enjellic.com (8.15.2/8.15.2/Submit) id 47QAbVEM003448;
	Mon, 26 Aug 2024 05:37:31 -0500
X-Authentication-Warning: blizzard.enjellic.com: greg set sender to greg@enjellic.com using -f
From: Greg Wettstein <greg@enjellic.com>
To: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jmorris@namei.org
Subject: [PATCH v4 12/14] Implement configuration and methods for default model.
Date: Mon, 26 Aug 2024 05:37:26 -0500
Message-Id: <20240826103728.3378-13-greg@enjellic.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240826103728.3378-1-greg@enjellic.com>
References: <20240826103728.3378-1-greg@enjellic.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The implementation of a TSEM model consists of three separate
components:

- bypasses array

- event initialization method

- event coefficient mapping method.

Boolean true values in the bypasses array is used to indicate
that the event should be completely bypassed.

The event initialization initializes the event description
structure using the characteristics of the event.

The event coefficient mapping method is responsible for
generating the security event coefficient from the event
description structure.

The model0.c file provides the model components for the default
deterministic model implemented by the kernel.
---
 security/tsem/model0.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 security/tsem/model0.c

diff --git a/security/tsem/model0.c b/security/tsem/model0.c
new file mode 100644
index 000000000000..347ed8584842
--- /dev/null
+++ b/security/tsem/model0.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Copyright (C) 2024 Enjellic Systems Development, LLC
+ * Author: Dr. Greg Wettstein <greg@enjellic.com>
+ *
+ * This file contains methods and definitions for the 'model0'
+ * security model implementation.  This is the default model that
+ * TSEM implements.
+ */
+
+#include "tsem.h"
+
+static bool event_bypasses[TSEM_EVENT_CNT];
+
+const struct tsem_context_ops tsem_model0_ops = {
+	.name = "model0",
+	.bypasses = event_bypasses,
+	.init = tsem_event_generate,
+	.map = tsem_map_event
+};
-- 
2.39.1

