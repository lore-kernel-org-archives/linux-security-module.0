Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795436601;
	b=03xsx/Mnk1MmR54hMyfVa2x88IkFqTuaI5FwBvtNF/gkNcL7QGYGL5ub0IkwDnMBQhjO
	 E7K0wW6x9bBx4Tk95YSm93mi/h+vK+8VITXrJly584Ylpo6cLfm13gK0NeWYNzUUiAMgk
	 g5V3ctj1k2CIDImQ+o5ZJmL89gNVs6HCmJrxD08qJYRrGLHZ+AI5JJFYxT9I0nAWrtM7t
	 /ixbyQx6xjqTUpw5RL/NaqreBOKLHMjmljILo+WnlpEGZzV6R6ehrOZAiKtEsbwLbFmTa
	 AfQpOMfMdF8gmNhdFj4LTvER5j6s7WtAfXfOYshvX6Lena976PcgiIq2KHY0qDqJUqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795436601;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qaygILgKGr+m4nETnmDucsENdqt4UIBlGB54KJkiaV4=;
	b=qa/T7/H5DgkCug1xFd5IFhWJXtnpWHTW2JXoriIU+D93230rWDPN+8zeDVi1vy1Ve1ls
	 vYQ8Bgn2Ji+dDoGhsRksJhBTHpFRM71RPrWDApZ+yQYlfwysKPMMuhLpOtan7TfTWkeHn
	 hy9510QASOwssmRXAFKboSGTqEE1Xzdg2GC9c/0RxNhuL1XVwLrmk/yHdnsHblqdalwg2
	 hbDHOrxIs01vqNKRnEnT9SHeKe8imauU8eQCFtp6AUB0S8RUeJh4USeMjIsimuVpP7JFn
	 Co50A4BAzp+dQnaHvChrytntD493mUsLIuPQ58plSXEfdwL4hDiViEQ7vHre62W9GXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wb8uXtL2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB22D606A31A
	for <linux-security-module@vger.kernel.org>; Mon, 23 Nov 2026 12:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wb8uXtL2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDCF21F000D1
	for <linux-security-module@vger.kernel.org>; Mon, 23 Nov 2026 12:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795436601;
	bh=qaygILgKGr+m4nETnmDucsENdqt4UIBlGB54KJkiaV4=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Wb8uXtL2csDHGeUPngbuiUVziurQ0+cEctjQ2r2TEwQkdwo4oKihFALZTgaZD0GWl
	 KC6daUwDRy5tF05YxCEBufB6mOCtxPhJLzkByHfIBWbUBYANHVIcFxIFM2zwCskcbc
	 Y9mW1ltOkXJrsGVr5nhSWfoICXmY+6SS6aFT9cQNUX0HArcQAaaGnsneJfeeNDQBTb
	 eXSukgiSj0jZmJY4/kpE27s8oIaSeekMDzxqPKboLnXEivdgDL12izCaAig86zPy/Q
	 9SdKKnCvQZnaWz3Umn9K5jZ9iEvIBuEFkSnZ3X2jtmM0cQ16G+/Ic6VHwg9hp7NlNs
	 uFVMe+S006avA==
Message-ID: <sashiko-outbox-229208@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] apparmor: mediate file-generated signals
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <CA5F08835E9B673D+4c9dbc21026e6b6ad4acb1f90255da95c3bbc0b1.1795434950.git.shilc2025@mail.sustech.edu.cn>
References: <cover.1795434950.git.shilc2025@mail.sustech.edu.cn>
 <CA5F08835E9B673D+4c9dbc21026e6b6ad4acb1f90255da95c3bbc0b1.1795434950.git.shilc2025@mail.sustech.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 12:23:20 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] apparmor: nonexistent fown->cred access in
  apparmor_file_send_sigiotask()
--

commit adb1f63ac0d010cf15636cb43e53dd9299246228
Author: Shi Lecun <shilc2025@mail.sustech.edu.cn>

apparmor: mediate file-generated signals

This commit adds a file_send_sigiotask hook to AppArmor to mediate
file-generated SIGIO and SIGURG notifications.

Link: https://lore.kernel.org/all/20261120-unrentabel-bambus-genuss-0db3576=
a8f57@brauner/

> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index d502ad0ac26f5..1a6e49bd50311 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
[ ... ]
> @@ -1047,6 +1044,13 @@ static int apparmor_task_kill(struct task_struct *=
target, struct kernel_siginfo
>  	return error;
>  }
> =20
> +static int apparmor_file_send_sigiotask(struct task_struct *target,
> +					struct fown_struct *fown, int sig)
> +{
> +	lockdep_assert_held(&fown->lock);
> +	return apparmor_task_kill(target, NULL, sig ? sig : SIGIO, fown->cred);
> +}

[Severity: High]
Does this compile when CONFIG_SECURITY_APPARMOR is enabled?

struct fown_struct has no cred member; __f_setown() only records uid and
euid on f_owner and calls security_file_set_fowner(filp) so LSMs can store
the file owner context in their file security blob via fown->file.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/54EBCABD3ACBF0A5+9d=
780112081161e2f99fe501c2c38f1614a68a42.1795434950.git.shilc2025@mail.sustec=
h.edu.cn?part=3D2
