From: igor.stoppa@gmail.com (Igor Stoppa)
Date: Sun, 29 Apr 2018 06:45:41 +0400
Subject: [PATCH 2/3] Add label and license to genalloc.rst
In-Reply-To: <20180429024542.19475-1-igor.stoppa@huawei.com>
References: <20180429024542.19475-1-igor.stoppa@huawei.com>
Message-ID: <20180429024542.19475-3-igor.stoppa@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Add SPDX license to genalloc.rst, then a label, to allow cross-referencing.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
---
 Documentation/core-api/genalloc.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/core-api/genalloc.rst b/Documentation/core-api/genalloc.rst
index 6b38a39fab24..0b5ade832ee8 100644
--- a/Documentation/core-api/genalloc.rst
+++ b/Documentation/core-api/genalloc.rst
@@ -1,3 +1,7 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. _genalloc:
+
 The genalloc/genpool subsystem
 ==============================
 
-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
