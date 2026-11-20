Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.194
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795164708;
	b=1dQIX/fNk2i0nRPrpfcLLpzzJVMHU5wcmK5tZAhRtlCZ6L72wNe1sgPC/K2GB4c4+Bpd
	 BVT4C2uOfBfUmFaUi60kxsjk0UCTaCfKnQdaNdyutSFe2o7gYA4nK22+2uLF6HFglh5zg
	 tu5wpx9Qc9KiyH5Xvy2Hh3MQldjNUO8gdxtXLZXPWHwaD4QzczpbFI9frZMaalkGjDz2v
	 bvHU8wgaQbCugNh/PYDXkR33K9/MjIUE5FPLoANjrGaXTNXHWyqg7mdyQJBbvYZ03EqZ0
	 Iy4FCwpQRYOLsyapRSW17EOOPRzOuiJtgcZd5lqEnI8XZlEbi0PNBDwy2COnu1nCr9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795164708;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=KKdx234HIc0ImmFL6/W/0CUujjCP+++uYg5Sa1Vuj70=;
	b=tzrEq2L2f73tTXaaETCajMn5tmHCrIWVK93FXnpjUN4zUfzm7piGGQpCuYQoODMeQLzM
	 9sxo6Rgdo67S/4zbAMhxflrU/UTBiD5zE5+TJ9gMAzxUZOCq5Vxwu5QHMJlERrcsj8LUT
	 /XfX+y2v5zQiX3c3ItwSFZ+G8ZO1EurURBhFvobDj5ZHjya3ZoE8KdVOTEbOxHPRW4zoN
	 kCq5dZSswvfq/GlVhNKkT2KKxWseOp4IOQ1TYeQBXJdsR/jjLiVcbTkehwQrlRMvs/xeT
	 c/E+2VRdF3NamRZpe9n3gTQ5ZpeI4C1MXYLWsvgMixiGhpKAJ+7+qHWmm7G9dTm2P7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="GsxEN/3F";
	arc=none smtp.remote-ip=74.125.82.194
Received: from mail-dy1-f194.google.com (mail-dy1-f194.google.com [74.125.82.194])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B9A606A326
	for <linux-security-module@vger.kernel.org>; Fri, 20 Nov 2026 08:51:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7B9A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GsxEN/3F
Received: by mail-dy1-f194.google.com with SMTP id 5a478bee46e88-380c28f9e35so1667505eec.1
        for <linux-security-module@vger.kernel.org>; Fri, 20 Nov 2026 00:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795164707; x=1795769507; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KKdx234HIc0ImmFL6/W/0CUujjCP+++uYg5Sa1Vuj70=;
        b=GsxEN/3FGlHyHllEDootP16iud5WiCrZc73xDVDAHfJkuu05N65EVXrykG1lW3GaW0
         qvcJYJ5ND7nDAWsyDu5U/34h0PGvGS0UaTrccNRYGm2yIb86vN3SO1Nw5EH94n3WeuAm
         OFfxY9Y9So+11iDr0O9jhFezi/7BhsAmACc9fB9S5q+TFy57ptCl9tH1YCrheKUm1oks
         AhpXvfkUX3T2ewVmHBw9Cy6SkMkpsK0scXtCbsoEUqeOb2a2/K976S++NDcOAE24tXJk
         OTBow42b0GbQfzb/rBEWIrPCtFxz71d9ZIZ6rn0cl8Y0ZWuqQCv2XDkwBc9Oxr+F2K26
         Ki1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795164707; x=1795769507;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KKdx234HIc0ImmFL6/W/0CUujjCP+++uYg5Sa1Vuj70=;
        b=EqRTMotx0Y9Wyfgi1kszhwTG+jkcY7BswZstIBeDz6av0hy9DhqwA77tcnrHOqD4Me
         O2zl8Lj93Y6QTWL9jwQSYh775inKSwWkQszAPcPYiquO+9wlq6ca7A+tteUaB3lHwmHp
         Woe+MwD/BglVZ58ii53zxLpaFDSq7WnLi/tmMtbGqXVP8UY59QE3GwBebsbpS+7pU0A+
         MvehF3ZjNE4aM1IA68vSWTzD8TZXtHChnV/dD6yxCxzQ7o2tKULQYJV8MWYkP2dEmp4f
         OPwzIoE0yEHARJUe6/Nqrx0fmqEqLV1CiFmpt/WNrkTKQBNYrNYS19OJPKgxAKB7oZks
         QbMQ==
X-Forwarded-Encrypted: i=1; AL+hErERtoYUZXBHaBTavwlIbjNNfY99Uvr0XDLHvDLsP/H5mqtj48lOj4HUJ6uFk4ZjCY82UtlN/FmpyGaM/v7tNKoQ+aUbGGQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/3VwjqKi2e9wzhO/ff1x/mhcBLuOqnXGqLq7EUf+H+ZP7ULa4/
	PaOtdxSRDTqjWXz8dT1HhncM8oXjoM4GvoLaRp83LUOpRor0a1iAo875
X-Gm-Gg: AZFdTZfy+3RU9LGqxqGmHl4G2WHswzd3V86EIKKep2Dxy90BFp2UYx+bbIIMjqqqjTa
	SMEreLWB3HdLy3NVnvclMgFAS+8T6ayy56MOFdFVyZK4JKxn6Q1DGorSk2/XlcZIquKR7A6mBcw
	p6p3mfwhCsT4wporxzKsy+E1NI7rVu+hUwQxm7U1HCTZljYDWHkp+4/xwxMLAAr5948M/F/VTsp
	KhqbFMIVmKxcp1M+q749NTPjpD1cpSS1P1EmZhuCpfI0dZ3qj3IQdnjfBRxDs4DKPq9NmtD8cz9
	loOWmZOmPeCKG6m+Lckka1B/vtXHLXwdlvoQ4Ft2vLuPmUbZagJ6W/9I7hOOztQTF0K4ru1Kh5w
	fStF9qcDfcQ9quCcDrXYzzxq46yhZvvBFIlmATUajJqmN6aJIE0Gj+mG0ZcyFVXHIdPa1yAQohX
	TXU/RAX+bmtuitWQ1EApLz4VEPj769UvJhDqmucNCFISR4GOenlwvigRdr7wU67eln4/16lTKhm
	h62Xw/EBnXyfAkEtBtgXAXI0uhrMCnYv6wSUh49p3pX5oE9mAvTHA3EtJDyeZuTt0WmijpI1HCc
	E/oSiLM9Lgi3DvG2Fe++cSI1z7AEXvhyAUMt56j5Ci+hIgO1YTYhm6tpoX6HJgDJ4SOEad1Pnow
	7uOug/NxGum9tatpmbTucf/oj5EvPmJvB//34DQ==
X-Received: by 2002:a05:7300:fb07:b0:36d:158c:e31d with SMTP id 5a478bee46e88-384b446d603mr3319103eec.18.1795164706953;
        Fri, 20 Nov 2026 00:51:46 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385f68bc0adsm3495445eec.13.2026.11.20.00.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 00:51:46 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: hannes@cmpxchg.org
Cc: surenb@google.com,
	peterz@infradead.org,
	mingo@redhat.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	cerasuolodomenico@gmail.com,
	mic@digikod.net,
	gnoack3000@gmail.com,
	didtldms2525@jnu.ac.kr,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dennylin0707@gmail.com
Subject: [PATCH v2] sched/psi: Check CAP_SYS_RESOURCE in the initial user namespace
Date: Fri, 20 Nov 2026 08:51:18 +0000
Message-ID: <20261120085135.40368-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit d82caa273565 ("sched/psi: Allow unprivileged polling of N*2s
period") moved the CAP_SYS_RESOURCE check for psi triggers from the
open() of the /proc/pressure files to psi_trigger_create(), so that the
credentials of the opener decide whether a trigger is privileged. In
doing so it replaced capable(CAP_SYS_RESOURCE) with a direct test of the
opener's effective capability set:

	privileged = cap_raised(file->f_cred->cap_effective, CAP_SYS_RESOURCE);

Unlike capable(), cap_raised() does not check against the initial user
namespace and does not go through the LSM capable hook. A task that
creates a user namespace has a full effective set inside it, so an
unprivileged user gets privileged triggers on /proc/pressure/* and on
delegated cgroup pressure files: windows that are not a multiple of 2s,
served by the SCHED_FIFO psimon kthread, which the N*2s rule was meant
to keep from unprivileged users. LSM policies that deny CAP_SYS_RESOURCE
are not consulted either.

Use file_ns_capable(), which checks the opener's credentials against the
given user namespace through security_capable(). This brings back the
user namespace and LSM checks of the capable() call it replaced.

Fixes: d82caa273565 ("sched/psi: Allow unprivileged polling of N*2s period")
Reported-by: Sieun Yang <didtldms2525@jnu.ac.kr>
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
Tested-by: Sieun Yang <didtldms2525@jnu.ac.kr>
Tested-by: Mickaël Salaün <mic@digikod.net>
Reviewed-by: Mickaël Salaün <mic@digikod.net>
Cc: stable@vger.kernel.org
---
v2: Collect Reported-by, Tested-by and Reviewed-by tags; no code change.
v1: https://lore.kernel.org/all/20261106120004.90041-1-dennylin0707@gmail.com/

 kernel/sched/psi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 7c5381423334..cf2593183b25 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -1347,7 +1347,7 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group, char *buf,
 	 * Checking the privilege here on file->f_cred implies that a privileged user
 	 * could open the file and delegate the write to an unprivileged one.
 	 */
-	privileged = cap_raised(file->f_cred->cap_effective, CAP_SYS_RESOURCE);
+	privileged = file_ns_capable(file, &init_user_ns, CAP_SYS_RESOURCE);

 	if (sscanf(buf, "some %u %u", &threshold_us, &window_us) == 2)
 		state = PSI_IO_SOME + res * 2;
--
2.43.0
