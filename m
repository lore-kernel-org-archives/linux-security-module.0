Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802313;
	b=UxCmmTcbuq/v8Ar6NTRWDH9YXBBb4JTP2aQBXucWji9KPO12sOXd7hepwdIBInraJ8pA
	 aZQpbHbhtWgF7epP2cHVykF/AOSvMtXgCbuiVLgtGV+A5nYaZATqJxi92LHeTt0pRsfVi
	 I4AHtAT84tYiU5hzn6GDISKTzZ3EDLpMDfRyQb00MckYoJGIRUihN1j72GPLCf+ZIMyfI
	 +i6cQerMe28AoCB7/LjLpzA39M3wUpuE3F1DWbD0oqn0vUf4cyE9zpy8+Mb65xhzwYb8E
	 juBg822Bj1ggBeKYYseUViwMOMrRqMKRSTCQDT/XzJIfshaw+pvQFRz3zEABbgouOOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802313;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=hG5TpvKc4RXZNEF5W2j4YHWwCvUbIigtvZnxNoygjVI=;
	b=MkYht5FwAK2mkQWmt1E2KF1kLzeDkrlCmJIC3FeUfDKoQQVQL2GXhXGYz0ARNADsvdtu
	 afeic/bZpgXTtAa/huR1JG9c0mUC0ceuvexTFHYuimUFS8c/3gZ9tL2qXQ0OkqqMrAAR5
	 vFtgmmDRzfdPan8AOpUdcGmpLSKho0ChorNIDv+QEgulFRVvndlMhQhGu3ZwkssoKpVni
	 TBbAty1I2DvU/uqgrfCpJK1kJ5PciFCAJMTYjQQjuEQTyUGW9NuCzavw2GYNcCDOH8D5r
	 vLiAV9Si18qQrwu/N5AHAjLussvkOHkBVT+CnnKE32F/rm3ttpWun7tJkAoLVPy5a+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=Me5us99O;
	arc=none smtp.remote-ip=209.85.222.175
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988BB606A328
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 14:25:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 988BB606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=Me5us99O
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-93f2b8cf037so65650585a.1
        for <linux-security-module@vger.kernel.org>; Wed, 04 Nov 2026 06:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793802312; x=1794407112; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hG5TpvKc4RXZNEF5W2j4YHWwCvUbIigtvZnxNoygjVI=;
        b=Me5us99ORyikGlYv32KXXwL+de+2DN3/mIdVzQKsvY5g3V3q9glYRRmjw3EbJzrJwL
         6o+1aefKoApCTSMWYITTEgfkkX9OrVom9BZiuJc6HIver/ePVrBAyvSDKusN/sqWLAoR
         LW/PLyQW/pYMUV/nrLqY02Rwy2Gs765GuqLR7BtR3GRoM/N8ZLElpJhW5WKk1WtiAtLt
         qvU3T1vGe0lUiGFAo7ueOSNKUEdrDOW8qeHJeqWxB/7So7I2Z2CfFiX24nl6K/TmJl10
         wED5NLEW4WtPF/joR1Q46CF0ro+Y6jz+bxk864OcPZ/E7SVAWH2GvBSY4s9G8IzQkA9I
         nWMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793802312; x=1794407112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hG5TpvKc4RXZNEF5W2j4YHWwCvUbIigtvZnxNoygjVI=;
        b=MGQYbX90qt+HDQ1vPIVPVvvYUsap6ZZBo/YYM2PmHLiKe+B0I1IhJAHvJNvUDK/eR+
         Xk13Q24Tr0unx/uviK/h60Gv8RWNpLb5Ga0Ppy54E7UqOYjAmd8ZKQwb4uF7KrYHXr/R
         M3t666wjCE0ndgbYbIhifG92WkQ3fxNOzlq9tSzg0YXMe+mWHEykPWcr28mnvrayYocI
         14I4rPLbdFuPYT+otE16RivAT8IZPUQM41JJjKIB5vpFD1PNhLPZEtMHOYv98Du6T/Yu
         QnsuXKFGi68vl0y48mEFHMY+fEXMDQjUpD1wnffDM43Tqlmx/kDhDSL4HGg1WS67mrUN
         ebSA==
X-Forwarded-Encrypted: i=1; AKwUvBwuN2ZqIW/Yl9dcSLMh1QfR2IRtgp4opPjCTvJBWgBHfqfC+/c2ImZR0EnJsoRByGEijePbe7+gjJP0DwbZYKEv3UhmVVE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Zj4dg9G3IhkifcGcsyZlf9vvf3i8KNyHeq2BduoDz1sgYBcQl
	+va0J/N0sICexi1oIaj/e3UsWVHuYYwQNVyfIm3S6cpTkdLoykIPaimKJObfnLJwfBM=
X-Gm-Gg: AYBFou34INFSMRiODaOQntFMRWQXN77AwzmUvtcW/tHClwCf2yPq2nDB68hICluywfu
	+/r0+OlKApO8mI1fHhrSbTDL2kHpmLbqjkAzrEAorVr/hLrdRuu+DkQlIRQCT7HyXFYfuDeziLT
	neDnmCeSBbS/WG9jiiplvIuMJWaRzR/8FFWHyj/FdnmLMnLKglR3Ed0WJXMBCwZ1VHby7Dr5Rt/
	DaxFtTXXk/KNnrcfFg+aCVMvefho7Tx0JR3kO2dVr2wW1DiVTNj/yRs3EidA0rseJU4w+40I/un
	RZHe5u0r5APERPRriFBdCDBEdXSJkbGGhwNkSCGr2Fo9hzWBjKcfTlF1JW0iScw8MAIQXW97Lfg
	W1+q/zUqWkcmclbB4wv5V68vVx5namr2E0enm4o/7nni+LG9FA/hViu5jXtRKG3W2ctTatqqS5A
	W0tzj1Tpz0HdvP8kcEkLBz3h5l3kmb/8h4G8xi4+nnHPzKdCaOBQafxAHxzvW6p2p5IWFHUHNMe
	w6+ek0pamwKT3ONWgB4Mh8Kgsx3QnIgqpeG2x+eP5DKfn0tpzkMho+lZEqmszlru17WjNE88PJk
	LDyFwreXOraJw+wMNnQomrzzKqNRRDFyjn/z3NfHOyEMhg==
X-Received: by 2002:a05:620a:19a5:b0:940:f224:5a85 with SMTP id af79cd13be357-944217ea7f2mr2751408785a.71.1793802311660;
        Wed, 04 Nov 2026 06:25:11 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d483d762sm211949985a.27.2026.11.04.06.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 06:25:10 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 04 Nov 2026 14:24:38 +0000
Subject: [PATCH v2 11/13] fs/resctrl: use cred_ids_allow_move()
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-b4-cred-ids-v2-11-956213608f16@toxicpanda.com>
References: <20261104-b4-cred-ids-v2-0-956213608f16@toxicpanda.com>
In-Reply-To: <20261104-b4-cred-ids-v2-0-956213608f16@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>, 
 Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <sergeh@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793802280; l=938;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=spH7I2p6KlxAWtKZEKyVCuKK4ojI0D9bbJfweH6j3lY=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QH5hz21Zf0jQmKY+SmyRld9bkbHzoU5X3h1MbybRG+3C4m7r9/TrMSg5RPbgUNqsIz2rKJMNin3
 xmVcg48bAeQA=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

rdtgroup_task_write_permission() makes the comparisons of the cgroup v1
code, euid 0 included. Use the library.

No functional change.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/resctrl/rdtgroup.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 57ab090072c2..6b7b7daa9fd3 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -732,9 +732,7 @@ static int rdtgroup_task_write_permission(struct task_struct *task,
 	 * Even if we're attaching all tasks in the thread group, we only
 	 * need to check permissions on one of them.
 	 */
-	if (!uid_eq(cred->euid, GLOBAL_ROOT_UID) &&
-	    !uid_eq(cred->euid, tcred->uid) &&
-	    !uid_eq(cred->euid, tcred->suid)) {
+	if (!cred_ids_allow_move(cred, tcred)) {
 		rdt_last_cmd_printf("No permission to move task %d\n", task->pid);
 		ret = -EPERM;
 	}

-- 
2.55.0

