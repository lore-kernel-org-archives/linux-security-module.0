Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7ACB3B4E84
	for <linux-security-module@vger.kernel.org>; Sun, 18 Oct 2026 17:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792344744; cv=none; b=E7olMW9nrI4JRJYSF+9GjVydMiyYpw5IzJAalpx2bAJXaH5d3GMnNGWPRFtuJ3cFJUMretRMDVrU0vDYPBjEfaIACsl6bqJ5qFyexk51l6yJhLmYsz2cE2ZBDHAXha7NQJ/VyLcfAqwzX/cLEkgkwZqEEBlQARzUcToJi83omg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792344744; c=relaxed/simple;
	bh=VuhplGOEcquV18uiiK4/Ap3qkFtEFAfeXJoR+tCujYI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HN4fiiUEQCasYVwjxAn+emkNsMPAifO2Q0YavNKbtjuWPIWWONJFD620b7zh2su1ro/jIghZTe8gHuFfGukAsqBJmtFlDyAzDvuW6kV4wNxzy67GgVTvmoIv8otdR4FrLsUfrMjdgOAMnH1DM4GaopO/ho7Lo9nOCSTyXwlnQbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=A1h8DTFO; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="A1h8DTFO"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-93e7ad9f78dso172506685a.1
        for <linux-security-module@vger.kernel.org>; Sun, 18 Oct 2026 10:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792344741; x=1792949541; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gTYMw8Ue/2nfIYqwtO0taqjwjGSVkOQsjNTmpCNugZ8=;
        b=A1h8DTFOhCqvx8rotBFvDkIP7T05A4ZGeAs2KZ2yAUITFvik0ZChp92Dao7UAFGyv8
         JbX/V3HZxUNwWCTq0o3K0DQ9BziMwBcYyKvYKDKe4gV8Hgrn2OXX3Tytw7C+gMDedUC1
         d9px4hY3+AzxKtV4kcBh/Aa7MGcxlYx3NHacYkRD3cHp0pq4nYLNkXiZYgoZfbtJH0En
         0pmw/LF1E/SdDjoS8yz2IhBR+zf+PAlyoxm0RLmY33OQdSaYKLByToZsgvmVNDrSpkAZ
         6PRkhgACPI2/0uN4h7BD2bBXzvrExlXnkIACev/cPEoC1ZTVsyxkxwOoM04orGXaxWmd
         /MEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792344741; x=1792949541;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gTYMw8Ue/2nfIYqwtO0taqjwjGSVkOQsjNTmpCNugZ8=;
        b=jdDeYb0cjBwe7iInbjhh8jKoxHifcM4JQAncL75RUDs/Ho6jR9dCr+irQrWo7RfJ6G
         fjcb9gzlnVULwq8l6m17zmVI98EI7ELNVqdxc9lxnYYQDUSQNrCcGQC43dIisAUuJ6gs
         OCy4cSYhVdv9l4yx31yBqjIiNTuRcPuM9L2ho7o+/vO0EwlcRLNmaARpxkNMeZhM+ZJ+
         ihwuVWJChr9v0WThhnXPHSRneqxN9dAQS96FxiWA9Os5ASa/kI9kX4tft2SfYlaepTI7
         EfV8M2du2TZwUtSDcPae4bsDjLpwdviNvPaVqFxkOFYmOESnB/MqOWXkAczksNQyQvQJ
         vKSg==
X-Forwarded-Encrypted: i=1; AKwUvBw8tqAluRBHnB6IzxG6uzT/dsJ1CqPeDU1kR1Ylv1YFl1Nm8tM/yQ3IVM0w4sew60Glylvq2Ui2I0WjG+jDwfsagr1F+Y4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLkudiVA58i0rMpsf/76AeB8bnY5hSoDH1q9QAv8+9XPjvqbAFh
	etuC1Q1PBdm1eh/xB+uRoAYim1V9QbN0Yx4n2K7CP+GjEGLPsl8cx8hVVjT4+fBIGPo64x3eXKo
	8ihyd
X-Gm-Gg: AYBFou1bfTqoRGxXg//xOLLsPo+0dQrk1/UGUQoJDhVhFy2yA4qcLicsaqG7VHfC8QF
	Im+lCAYC5lbeDBCq5OkWombTsNVnKalW/Oa2eUqWLJURAjsQss5GnzQTxhFcaKMZ30dKWCeQV7z
	YGH1vIbCBcy83XoEXkhvMJFqkKhS2TXuoZDJiooiVHsgCMP2dvMeXNo9wPwR5nTbjWwYpu79IIr
	mgdLJSknE59Hcy7M1tDmoHpGZerrRirJRKfu4NyFEvbpfD7B+W5oRibBd2fKhmYLsKoqtbQoOit
	JZ9BJGwnKmOv1u5cR2yhmP75ULg24EuXBOupBl3RLgByrDEfOGyIOErdDrj3iRadlbw/p5qkv8B
	aKNkHWn8nHYY2egTVHj6havUcFxUfEKQfa93XUJGgJiwIuR4QN4v7y/IO2CuSQkhUOjNPEtNt4z
	spGbrNC/QhBaH7IqWhaDAfXxvRIhfv48S+pAJMo6liYyHho7QStuXI2yKkmz5cdwU61fcDvaXPz
	AOKvYP/QgLdmDdr
X-Received: by 2002:a05:620a:6405:b0:93e:c12c:f146 with SMTP id af79cd13be357-93f29e1a3c4mr926687085a.80.1792344741648;
        Sun, 18 Oct 2026 10:32:21 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91bd2158f7dsm68879786d6.6.2026.10.18.10.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 10:32:21 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Sun, 18 Oct 2026 17:31:53 +0000
Subject: [PATCH 11/13] fs/resctrl: use cred_ids_allow_move()
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261018-b4-cred-ids-v1-11-7bdf2db4ea9f@toxicpanda.com>
References: <20261018-b4-cred-ids-v1-0-7bdf2db4ea9f@toxicpanda.com>
In-Reply-To: <20261018-b4-cred-ids-v1-0-7bdf2db4ea9f@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>, 
 Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <sergeh@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1792344715; l=956;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=VuhplGOEcquV18uiiK4/Ap3qkFtEFAfeXJoR+tCujYI=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QLNRA1AncoNnP9T/8AZep1DvvZ6xZrhrXQzAtYpQpb4+LGe5QZwUSuG+P15cUom979wTItt+tJL
 27wFY3xY5egc=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

rdtgroup_task_write_permission() makes the comparisons of the cgroup v1
code, euid 0 included. Use the library.

No functional change.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/resctrl/rdtgroup.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 5dcbb0a964e8..d032ea9ca8c6 100644
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

