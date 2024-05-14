Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE5F181D08
	for <linux-security-module@vger.kernel.org>; Tue, 14 May 2024 22:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715726924; cv=none; b=HhidQTdSh2hxWdBwvij4C7WUs6k6AMWPz5ThqYnUiR6asJ1zvpW2ixrqw0Hopv0gSrLo8X8BLk+m9kxmslpyXS/OYV6fZmAMsKJRSE+SW/x5nEa+/biKG/tCN70NBtsotod/Osm+bFMxKAdQOmfqv6bmxrV2cuCUmMz0ouwVLmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715726924; c=relaxed/simple;
	bh=J7vPh0ZbPIZnc4W98FXR0VGHZuZYhbZC2ygC3LT6oBs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KYUKys9hb+RxOuLYddc6AiYMWXuNtZ2OAOquI0GxK8af3Ic/beO++QTnQ0EdGcjMeM2X6hnR+cDsUb3WuaXrBzGpKW9Wo/TBJ6cqVoJv0So2mjXdBrPjxddX4YtscA5K8doSxDnQm1YrRi52rDtXvN+cgbDF/KBxvwYfer07x1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KFjZjbH9; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KFjZjbH9"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2b4952a1aecso4187092a91.3
        for <linux-security-module@vger.kernel.org>; Tue, 14 May 2024 15:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715726922; x=1716331722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7dEnatMats0sY9eR6iWDX8uys8lNwT71usJDglUkjFU=;
        b=KFjZjbH9kgedpzd8DWp/husbn61V/lNXNlDfKResCDliU+375dKCXPSW7C7pVTdZDO
         rAkDqVZBrtUl57x31u6v0OqIwuN1ZQqlRsL9yzkGwSvYTqlWHYb1LV1k9kqSXYRtgiIA
         RaIbX3wvbub0PumdCh1Qu/OmgEMBc/w++qe20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715726922; x=1716331722;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7dEnatMats0sY9eR6iWDX8uys8lNwT71usJDglUkjFU=;
        b=MhN9589UFUystH8UVeNEUJ7yRxl5X0W5rwCMO7RI2mUHKr6e+VCtE4zVgCrw9GTeJr
         D5FPQtHcGCDWFzjTwaDfQCJu3O93HYJ4E5II9E5BXT0TSaKeadMD8x6/D3n9onZQSCR3
         mWNOsZd/PLe6Du76oHVgeQRPcO5Pw7SEgcO04imJAFjYka2Q/0lP/zcGHoPbCQpT88mx
         dlJI+CRtDJedb6L9F00e5pou3RAXVdkLTYpSz4Kj7bXQMOhvDhfsH3/H+l4swaiiHfNj
         2+hx7oBngV7HK+N3a1zNXd+iKfiQGIG0C8T04VYEV3MLP8DFQusmukIOsD3tSRPofEJF
         vOdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNLzWo84VoMJJEA6xeZnzipdgIL3HUHmvBu+T3QG6rrHnnIiXobZuK9fGzHF4/4wYZCpJkwT6kJ04pA0itcb679SH0r/DlxXh4awzLewgZs7NczZxO
X-Gm-Message-State: AOJu0YxT8TvYsmmN0zb01SZBBUg39He8F9z+L6Iqo1hHyhmnbKCq64yd
	AQQuxyMymT9Jj+oWTTO6/DlxJbJYQxOCYrkUzqENcnRq7+XrpMmH3rJLz7+LKA==
X-Google-Smtp-Source: AGHT+IFNYthq6sGRj5beJQGDuOSDHf6eMfI+iPOay6PKYPk2IVvOV/nkNwPHeh6QcabowUJdNEzJDA==
X-Received: by 2002:a17:90a:aa12:b0:2b1:6686:dd7b with SMTP id 98e67ed59e1d1-2b6ccb7e416mr12324060a91.33.1715726922083;
        Tue, 14 May 2024 15:48:42 -0700 (PDT)
Received: from localhost (4.198.125.34.bc.googleusercontent.com. [34.125.198.4])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2b671782d89sm10230359a91.55.2024.05.14.15.48.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 15:48:41 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: Kees Cook <keescook@chromium.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	linux-security-module@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Douglas Anderson <dianders@chromium.org>
Subject: [PATCH] loadpin: Prevent SECURITY_LOADPIN_ENFORCE=y without module decompression
Date: Tue, 14 May 2024 15:48:38 -0700
Message-ID: <20240514224839.2526112-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If modules are built compressed, and LoadPin is enforcing by default, we
must have in-kernel module decompression enabled (MODULE_DECOMPRESS).
Modules will fail to load without decompression built into the kernel
because they'll be blocked by LoadPin. Add a depends on clause to
prevent this combination.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 security/loadpin/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/security/loadpin/Kconfig b/security/loadpin/Kconfig
index 6724eaba3d36..8c22171088a7 100644
--- a/security/loadpin/Kconfig
+++ b/security/loadpin/Kconfig
@@ -14,6 +14,9 @@ config SECURITY_LOADPIN
 config SECURITY_LOADPIN_ENFORCE
 	bool "Enforce LoadPin at boot"
 	depends on SECURITY_LOADPIN
+	# Module compression breaks LoadPin unless modules are decompressed in
+	# the kernel.
+	depends on MODULE_COMPRESS_NONE || MODULE_DECOMPRESS
 	help
 	  If selected, LoadPin will enforce pinning at boot. If not
 	  selected, it can be enabled at boot with the kernel parameter

base-commit: 4cece764965020c22cff7665b18a012006359095
-- 
https://chromeos.dev

