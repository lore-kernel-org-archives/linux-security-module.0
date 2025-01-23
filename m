Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B761741D2;
	Thu, 23 Jan 2025 19:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737662248; cv=none; b=UiEwv/nhqFbow+P5/kl2Q/4SABD1hMoh+vSK+dt9HNzSjpzFYrxHrf1ru+27ptc+OyE+5ZpvW9qN/hLrVU77nV0neSBY6IT84jNZ8TQXreXseFNxl7KFnBPAtj1ASZmgdK1Wjw8SCZLeM5AEl7QcpPIVm3lmYADRK/FBhAETc3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737662248; c=relaxed/simple;
	bh=ajdgFugDtV/iFWheR0eshitdLUdyFAQt+XYa9k0Mll4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FlohRzJgRBVWt/fVZHVO1xk5+voALrH91PAlb/1l3M9UxF9WsCSyzGFKo/lSBVyikCVWem3DcprlfmDnp5iBz3YxvUHQMjFPu2bUtsyaX4jbJw8Suhw+DLww2ftggx6bANuVczsgnzbEIKq4eLhX05SqevwDNzq491Q45mYNlSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=a+dyasHG; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="a+dyasHG"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2eeb4d643a5so2584892a91.3;
        Thu, 23 Jan 2025 11:57:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737662246; x=1738267046;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GOwTSITdWxSRhub6Za29c5Wdoyuf6atairIJn2Az4eo=;
        b=ePp2qNCqavbmElOwnElXkDpWsiJHz/iYnCE5kpcFEBv7cVgCswPc/PR0QvhLBafLK+
         oLAtwxkxxB1MvKjSRMPK16H5aDTqsCTcJ7c2qZk058fyt4kt8FKflHLyuoCyp2WjjcZ1
         b0WkBbYjZBja7Lu5X+uLtIVZ2RzHhxPEewe1JA0WmottFgVL5uoofiQwZGbKYXAWISDM
         ZamSj2t5hmT/oHKGQ2cS7bh/agSPjwZmr4kWDFraEc0vQh71bP5YmlaAJNEeU/PghYLe
         /ts7lO1PGDvMULHmgsK4o71ChoyNiSzFcHx2390S3al5+MgmZF2cwj+02vJvNrFmF/3h
         dfGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQ2rciqG8RrjShJgGhveJSyyopSgefirI8kL95KF5YqFkr+3DTk+T18Cf7yyw3pAPdpa1k3/8ZeWrMzsY=@vger.kernel.org, AJvYcCX977LZevAZnZIE73m/HiSwT87jt/qCMJqI1kczFyZhFl8rc6k2h1DPcrgBm+9tUjAnfdSognQ+QrF0TyH2P/DxcvjCqOn/@vger.kernel.org
X-Gm-Message-State: AOJu0YzUfGSBmO/LFESN/VdSPs5iIt4VTvFlIcM+w6elAac31U78BsPe
	w4zF2z56Liytn4P03Njfw1QvsphJ5yanwHMDIkztlFk6jJCwQIxP
X-Gm-Gg: ASbGnctI9/n0bO4OZFh+mYNJOevI3nEqMIcYQhgG5dqA2Irs6QKA3YFyW/supSGX6qT
	8blDg4bX8bYHkhdAPWafVfL8YlOMU99B8Y0YwhRDp97j9e7rPhouDbWZCKve7cLW0paHTzOiItl
	kTxqswzcdnU4PG2LqRqvQe0osb7kkOXfZcQH1lzycAS3nIoQhYo63bd6V7uHNax46i+PzJTZjfk
	1YrM2Fxa1P+pEKrSUB44ucr6SL4sl93q0a4ENiwK0rEkHrBnAgMhSzkfd+ePbHsyvc39C7UUt/6
	izDYvCaq9FfqNlWHx1JTOg==
X-Google-Smtp-Source: AGHT+IFIHf7Ml0hlbVH+yfQ2Lodxd4V9tyopFz4fhKwwoKW8uWd4yMBnSwzGPlA5BLm7vg+BY+Qb6Q==
X-Received: by 2002:a17:90b:5146:b0:2ea:a25d:3baa with SMTP id 98e67ed59e1d1-2f782c6639dmr35379819a91.5.1737662246390;
        Thu, 23 Jan 2025 11:57:26 -0800 (PST)
Received: from mail.marliere.net (marliere.net. [24.199.118.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ac495d58077sm250246a12.53.2025.01.23.11.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 11:57:25 -0800 (PST)
From: Ricardo B. Marliere <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1737662244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GOwTSITdWxSRhub6Za29c5Wdoyuf6atairIJn2Az4eo=;
	b=a+dyasHGG4Bwknl2EBEfeNb24gQblX63vRRPypITuwA/Xm4j6Ovro0Bh/rs1dOGoqarDIR
	wUwIbtKc9BG1+1y0maCQASw9yjwiyejMzkuZR/L9GWesGODcfUSn3/UqGqXhI3wJIqzQ2K
	Ya5H6z4nlT2lMF7BlqCqtjBifPEZaNZf9kh2B+ajzXMupA2DnBItJMuOvWCWbgmiFQo1Uf
	lPh7vXcaWc/aFacqRNXVbMBAPFoiXoYWEMCKlo+hR+lA95r73p+HlKQAOLvD6HwKzQ6OA7
	0cEcC8XcklMwZFX9BKiPcF0yCr7PCkh7rUdhqST0J4MOEkfIH1FmH/upxe525w==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Thu, 23 Jan 2025 16:57:19 -0300
Subject: [PATCH] apparmor: Make sysctl table const
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250123-sysctl_const-jj-v1-1-8b9c04238aeb@suse.com>
X-B4-Tracking: v=1; b=H4sIAB6fkmcC/x3MQQrCMBBA0auUWTuYRHThVURkkk5tgiZhJkil9
 O6mLt/i/xWUJbLCdVhB+BM1ltxhDwOEmfKTMY7d4Iw7G+tOqF8N7fUIJWvDlNCG0dOFvDHE0Ks
 qPMXlf7zduz0poxfKYd4/KR2pVpJ3Ecy8NNi2HzUTGiGEAAAA
X-Change-ID: 20250123-sysctl_const-jj-1cdba6ab00ae
To: John Johansen <john.johansen@canonical.com>, 
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>
Cc: apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 "Ricardo B. Marliere" <rbm@suse.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1288; i=rbm@suse.com;
 h=from:subject:message-id; bh=ajdgFugDtV/iFWheR0eshitdLUdyFAQt+XYa9k0Mll4=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBnkp8g85TjP3lZGKhnRSUQuQ/fvrDJaXgd4gA4f
 NEnp+zEc5SJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZ5KfIAAKCRDJC4p8Y4ZY
 psWCEACDbBx786irWYdw65DETjBaAZ665lTvgBZP+GKsbAIyPvzN7VUSIwjkiD6tU0mCgnxmM4i
 /Q4a+bfKir5kWK4jMCQVKqwvzhJkqjVCE7SzdQGIPDUUEb3YpoyyvXZcfZUY6+1/Ou942o52rrX
 cWSJXRxdBalDkS24ScjgOpCa7yS6zNWwl20I5OnBtHmMJifzwqmDAXl/YVtSicCCTjrtWPf2VyO
 3l6sjYIpWg25AhjSy5TG59ZxjIiuTRTKG25BlltdrwkPMvByy11Kaj/GO4K+IQ9weTJFfcQpgnM
 3N5sPRS8+6mtTzRXWarJT9Yp4pClrvMG3/vyro7oQfFiBTwiuA075SNiZY6Pn/06vbwbFUhEzO3
 y/Af82Y/sPgmQOQvh+m9+ramErRY1gDGRYkBZnnvpZQePGAy3wXzyWt0q2U7vcsKNDeYyW99RRn
 KlDcTSjtpsOUV+KRK/QkqE1N2IujFSv11wCHUTWNFXVHU9raWp2FDZXGjs0n/R0wrzZLx+0OykC
 KhQlijf2j8mTru7s1OLUcfPOrFBMs4rjqtJU6a+py+SWQRE6Az4uyx7vBm104v/o77D+uA8FUFw
 6Dk0AU8dEA0IIKMN7o9MaHQNdSCgBJ0GuiX7TULg6FCwsOTDN5eaDYT1WSof8ukxmSivSTwXCLQ
 rFXSd/IUVYNXNag==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit 7abc9b53bd51 ("sysctl: allow registration of const struct
ctl_table"), the sysctl registration API allows for struct ctl_table to be
in read-only memory. Move apparmor_sysctl_table to be declared at build
time, instead of having to be dynamically allocated at boot time.

Cc: Thomas Weißschuh <linux@weissschuh.net>
Suggested-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Ricardo B. Marliere <rbm@suse.com>
---
 security/apparmor/lsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 0b4f7e2e4135503f0c78a050e82adb4ff853e9f4..93c7fcd875f764feee7fca6ac302e31ea081d18c 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -2205,7 +2205,7 @@ static int apparmor_dointvec(const struct ctl_table *table, int write,
 	return proc_dointvec(table, write, buffer, lenp, ppos);
 }
 
-static struct ctl_table apparmor_sysctl_table[] = {
+static const struct ctl_table apparmor_sysctl_table[] = {
 #ifdef CONFIG_USER_NS
 	{
 		.procname       = "unprivileged_userns_apparmor_policy",

---
base-commit: e6b087676954e36a7b1ed51249362bb499f8c1c2
change-id: 20250123-sysctl_const-jj-1cdba6ab00ae

Best regards,
-- 
Ricardo B. Marliere <rbm@suse.com>

