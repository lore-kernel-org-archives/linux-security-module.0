Received: from a6-244.smtp-out.eu-west-1.amazonses.com (a6-244.smtp-out.eu-west-1.amazonses.com [54.240.6.244])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E68F2BE02A;
	Wed, 11 Mar 2026 04:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.6.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773204971; cv=none; b=CZ2fALKTXmx17SQ90CHYnsAJ2WXBoMz/Iih6Pqy6eZsiZ52iD0SXlzQ2Ql48m5GTw/AaTEhXIrYkXFzVFrrwpusQYqP+27i7kBZldctD1Za05KfzlBCD8bMKZscm7V1sqIkpV9le08Y+tFX5Mep8LVriqTnMaoSfcRmOmo/BpGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773204971; c=relaxed/simple;
	bh=IEZUkQbx0zgTEmc0FnB7NekXvrn0lC6QXyV7hZ+LM9o=;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=IS3eYYyx6KSENAGVljMKSg2tFj+jBajHgsJXi2TPvVGW2GyQXQZG4EuGLS8guG2RMKYeZzofB3TJOGaWFjkSPUpSsFl9quP9dc3Q+L5ybT1nHZudg+D9yREiT/hrAegNnP+JKN22cVBzfrcp4lsD/dhfjj3Et9xxjKeRPxRREm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matrixforgelabs.com; spf=pass smtp.mailfrom=send.matrixforgelabs.com; dkim=pass (1024-bit key) header.d=matrixforgelabs.com header.i=@matrixforgelabs.com header.b=f8SL2Uco; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=RCLTCcBL; arc=none smtp.client-ip=54.240.6.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matrixforgelabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=send.matrixforgelabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=matrixforgelabs.com header.i=@matrixforgelabs.com header.b="f8SL2Uco";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="RCLTCcBL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=matrixforgelabs.com; t=1773204968;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=IEZUkQbx0zgTEmc0FnB7NekXvrn0lC6QXyV7hZ+LM9o=;
	b=f8SL2UcohYGTvugejKbGrz6Hy9NwdC/sTe01SzAIpAE5N/dt9wBVqUdcBWyBF/Dc
	ztlmtQxKirSG4WJxkn09TLghfO0jI0EMzek7Mhs6WrH5aK7joMgQF2GyiLTvmRl0OJA
	hPlk4Y5JBQrSmuGkYA/vZug8flOGxNfMBDEVIyEs=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1773204968;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=IEZUkQbx0zgTEmc0FnB7NekXvrn0lC6QXyV7hZ+LM9o=;
	b=RCLTCcBLUbFLwx1FEJXTf744hUHBk5XfxG2x+BWXazws59gSsAO8RjC7ER+MjgPt
	wc4l7pZN0dvSWhZ5kpiRAvjVLR5xoYb157NXODmm9SNzidmmxSu+h5Vv1uvObHjEryt
	ooHzkBi4ksmJt9HZXBTjgk/Zf9w/KtvJMMT8cu8k=
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311045601.649904-1-jamie@matrixforgelabs.com>
References: <20260311045601.649904-1-jamie@matrixforgelabs.com>
From: Jamie Lindsey <jamie@matrixforgelabs.com>
To: rust-for-linux@vger.kernel.org, linux-security-module@vger.kernel.org
Cc: ojeda@kernel.org, paul@paul-moore.com, aliceryhl@google.com, 
	jmorris@namei.org, serge@hallyn.com, jamie@matrixforgelabs.com
Subject: [PATCH 1/5] rust: bindings: include lsm_hooks.h to expose LSM
 types to bindgen
Message-ID: <0102019cdb4091f7-0241cacb-4b6f-4cc8-a979-21c0cb186be8-000000@eu-west-1.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Mar 2026 04:56:07 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.eu-west-1.dUvNRtpqGVRXeo8wh60CXsl7GQehaaQ6nnrtD0cVQa3Ql6wtvHFwU/L0ElxknTtyiIJqbukn1OjAm5wWeKC4/L/mSl4kXjXWbCD+H4nPl2leK4flNX+koNzOtq4VJ309U1FPreISQBpCbnqANIVuwUyneL8ocSNAtI9Qxd/4vCM=:1.eu-west-1.xc5b6Z4+0WlftYwtQHAHsTtsfYdZQImSOXWypZD9BdY=:AmazonSES
X-SES-Outgoing: 2026.03.11-54.240.6.244

Add lsm_hooks.h to bindings_helper.h so that bindgen generates Rust
bindings for lsm_id, lsm_info, security_hook_list, and LSM_ID_*
constants.  These are required by the Rust LSM abstraction layer
introduced in subsequent patches.

Placed alphabetically between jump_label=
.h and mdio.h.

Assisted-by: Claude:claude-sonnet-4-6
---
 rust/bindings/bindings_helper.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helpe=
r.h
index 083cc44aa952..b819592868e3 100644
--- a/rust/bindings/bindings_he=
lper.h
+++ b/rust/bindings/bindings_helper.h
@@ -63,6 +63,7 @@
 #include <linux/ioport.h>
 #include <linux/jiffies.h>
 #include <linux/jump_label.h>
+#include <linux/lsm_hooks.h>
 #include <linux/mdio.h>
 #include <linux/mm.h>
 #include <linux/miscdevice=
.h>
--=20
2.53.0

