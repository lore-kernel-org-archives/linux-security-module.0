Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03381184547
	for <linux-security-module@vger.kernel.org>; Thu, 22 Aug 2024 09:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724318298; cv=none; b=ih3jsCbaBTX5aKfgNcJ0+VBjdPCzGHH90OfGClKfe6uSE7Y+r7ROg5DtGQOFdEbM8wqe9BV1hwkMzKsrmnl2dM/ng194u/Xy49ruGJa69jTGjv/QtgbSVrEMAS8zIxhoNP8j7cRW9hHQDD0WhTxCTG2ZPWJERLztFDf0oeqA5hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724318298; c=relaxed/simple;
	bh=PR27knz+f7rBS+sSOwscBi+dZrd6DLD9pd9GPBU5j6w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ys0shpfg+YgytuJdsRZBZ4NHs303/1AFCIp3MNOq5YEcKFIuAjKK5K6gMYOY/y9h2tt7lzHQfFhAiEaJa2etdN0+5AuqwztcngmI/K6vyU63qJrx8+Ws3YPRrQpQTaX1zMnIppf5fE1tZQkY9j6jBEpArX2nRmqkBW4cvfH830M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cb4+3RyQ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cb4+3RyQ"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-201ee6b084bso5249795ad.2
        for <linux-security-module@vger.kernel.org>; Thu, 22 Aug 2024 02:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724318296; x=1724923096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xCZFoTbUEBtiRpLHShQuh2dKHbPMKcFLZYohtrbjcLc=;
        b=Cb4+3RyQNHLILDwgyUZxZtZcaWQ+HvHrmLm+DLnGeKOONcZRzAO6H/govxYQDvG5SI
         24ETsp+xrNwMnXg17vk88fLQcoNPwfcUNvSgLKT2bOTJjStEvmObmoLBY8+aymSXZjfU
         9tw+H0saeZ9UBBIsrR/l56iNr0PpBxf5PcK57EpykMbAC6UUTxffNbUEMucienOnHhb5
         4q3/aBX5GVFWAhAI80DLKdwwMJslvsBrEByanU4okmdZuSNfiRK6tYhLrTTfE7qpc7ug
         yY1pl503S63L0ydVq6jqZufZY0WDKL9lbVT+H3rTZG0dDgBB+U4Qwe5j8OXEPVAQapQx
         pMew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724318296; x=1724923096;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xCZFoTbUEBtiRpLHShQuh2dKHbPMKcFLZYohtrbjcLc=;
        b=ibBKY7EvLpfFbZhqCfIkmFBrIEllZFl+BBUOzrp69kp+Btf9zVs2lZ4tP7xEF5WJa9
         5KDsq7oGpYfVYA4HRsNnJwh2Uf9ZIi+YnGLS7Qy3SVpOjPVZZ2eGGJRLvNkX9sPawQtA
         aO++ak7zQtDE+SUNbXDxPJDRE/CjT+B/araUinVRIAn7XPUGzQj93cPU3oQqBF5sBMZe
         HcRHajpfjuhTQvPMFTQiA56IiCrWKMWUMavTMGoE/y2oLMqSH2XALvi26+/DzhjJD6g7
         He6Re10u3uegQ6KWrnrM44hmUVzwADCTa6snNFJylauELwGyUCkS54mshUgNKl6xGQmq
         ny8Q==
X-Gm-Message-State: AOJu0YyC1tUelLaGvrIuZljPVtvR2FNbfSZvJbRb6I9Wx8/KeDA79w40
	Ux8mM3+qp62A5V27DKGgxosKT61nta0tvrJ6gwIp6qoBNMuVbjP0EUEj9O1L9VA=
X-Google-Smtp-Source: AGHT+IEVD3fsfJgtoc9EGNvJ6ko9lTvUecuvde4zKylWzo1K4LFN/MusOdJdqHVkqjI/oWEzDypdsQ==
X-Received: by 2002:a17:903:32cd:b0:1fd:8eaf:ea73 with SMTP id d9443c01a7336-20367d497efmr67339615ad.35.1724318295799;
        Thu, 22 Aug 2024 02:18:15 -0700 (PDT)
Received: from localhost.localdomain ([119.194.145.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385566479sm8488105ad.58.2024.08.22.02.18.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 22 Aug 2024 02:18:15 -0700 (PDT)
From: GiSeong Ji <jiggyjiggy0323@gmail.com>
To: linux-security-module@vger.kernel.org
Cc: GiSeong Ji <jiggyjiggy0323@gmail.com>
Subject: [PATCH] security: smack: Fix indentation in smack_netfilter.c
Date: Thu, 22 Aug 2024 18:18:06 +0900
Message-Id: <20240822091806.89425-1-jiggyjiggy0323@gmail.com>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Aligned parameters in the function declaration of smack_ip_output
to adhere to the Linux kernel coding style guidelines.

The parameters of the smack_ip_output function were previously misaligned,
with the second and third parameters not aligned under the first parameter.
This change corrects the indentation, improving code readability and
maintaining consistency with the rest of the codebase.

Signed-off-by: GiSeong Ji <jiggyjiggy0323@gmail.com>
---
 security/smack/smack_netfilter.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/smack/smack_netfilter.c b/security/smack/smack_netfilter.c
index b945c1d3a743..ce06cd268d81 100644
--- a/security/smack/smack_netfilter.c
+++ b/security/smack/smack_netfilter.c
@@ -19,8 +19,8 @@
 #include "smack.h"
 
 static unsigned int smack_ip_output(void *priv,
-					struct sk_buff *skb,
-					const struct nf_hook_state *state)
+                                    struct sk_buff *skb,
+                                    const struct nf_hook_state *state)
 {
 	struct sock *sk = skb_to_full_sk(skb);
 	struct socket_smack *ssp;
-- 
2.39.1

