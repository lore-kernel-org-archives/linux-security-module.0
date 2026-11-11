Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=34.2.82.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794431853;
	b=0m1+oNtL6+gAKXGYV33ukqg3E88XU3ZFMndIeRIwirnbcqHCIkNsk5XPPhiB8oRkIq25
	 2wKTZsgVdUemflQO0bXOk+D0ZjZuMB3X+U4y/sfdfkzQexv13XHbk3rR/9x/0XJzno2fJ
	 YYqD9AiqD6ntDRfT/vFkeQwu+fP2tzgRSdkQ9G1y5XAZqNNc79ZpKUPpmbDeBLPVQM8fe
	 IS1G5OvcNulh34fibBc5xrPubt0gOKaKA1LHva/s+zRujvHakdiAh8kxKFTvaCZOniJW3
	 b80WNOy5jhNfbF+L9h3dSlorN8zSrkLzs+XkLIyufCNT50Hus7ih74IFR9Ateu06p+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794431853;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qUXUZqf9F6yEmce0lKvAbXv9BHFDkZZ+T87BE+Gogsc=;
	b=ptwvttnB1Keg0XNLoSE7KonnoyasHY6Ri61K5kaSMQezxpQ6tbh/TAIJvRXLptxWNXYX
	 w5sJjvFUrJR5GYaBS90Ys+hdtotBjIghlmCdMYMENKYHuvlGmo6i+e0KSWvljTEmmS968
	 hzOY5lcnH8f9tnJQ41EcaiYgJHXrYQDac0CWvdVwtjqqu2isIiaOpmt56MAFPwMSzxtB9
	 NM3OoJ/tO5tQzXOB/0ghLC/QfyXiTs+xep52RG9JuVWOGPG/M7kPixN3xpQf2c/q5nypc
	 gRiWeKjg0pBY7CpM2Ju8uRSpPjHIcPGKA9FMfrl7d3O/pVyOoi9ajdnf0hzXtpzsLzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.pl;
	spf=pass smtp.mailfrom=yahoo.pl;
	dkim=pass header.d=yahoo.pl header.i=@yahoo.pl header.a=rsa-sha256 header.s=s2048 header.b=JZB0nEJ3;
	arc=none smtp.remote-ip=34.2.82.16
Received: from sonic.asd.mail.yahoo.com (sonic-euwe1-0017.asd.mail.yahoo.com [34.2.82.16])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CBF606A327
	for <linux-security-module@vger.kernel.org>; Wed, 11 Nov 2026 21:17:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8CBF606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yahoo.pl header.i=@yahoo.pl header.a=rsa-sha256 header.s=s2048 header.b=JZB0nEJ3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.pl; s=s2048; t=1794431849; bh=qUXUZqf9F6yEmce0lKvAbXv9BHFDkZZ+T87BE+Gogsc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=JZB0nEJ3ByjHPn++GKPuaC+KLA5/yhSsjERIQWA4UzbTBN8wB68EM6N+MblQez1yGQfL4P22dWxF/RO+NJYRMx8Xm6/iX53p0OlInRNA2YPOROfu36n4MPjHqBA+70QeT0OEtSksfOdo5nvmI+Fdfps7eMONmGnsMJbs8PoOklv/pdH5WI5nRSfNnFus6D/pdQoXvmp40dXAG02lp1IxO8dBWTGGmJLnF0YWCwC9sox/gJEmuPzFuBUwONpqxplBHA5+SptTs49cN8Z2SWNiri1Mg1nuEadY/DpLesgjGAsQCu4I0fWDCa8FFSPsRwbVJaPY9cxbDdmljwKIspcflg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1794431849; bh=ZxICgkbLIgjxN3MSLSYwZHx7SJLDhy9/C15ZzG7QjFG=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=JS9Hta9FpTmgDUtWoGQ4hehltgfKz3qwBmU84KrkpWIgMeWTeq2DB4ZBjXLi0zcmnS0WGjh0k9nPsP/JU6aoNj/6Ekv+vQdb+tYI2LFQbfwEtKtIhxO/29i9Hy4RwK31Hsa3p3uQ8HzzdRTmbU7MwxhxquybcKzVyDbyaGLCCbeEuxwkxJc2EE9tguo48+wIBm2y2zKtxCw3L30oQqygxN2yDfmaDBsvmoKxDezIOtngFr+bCaGbB8P5spO6jbL7f2XZBuJ/NBwXLP2/aiduAAZKrpgMsRzJKxsyWJfscC3dCZ61TxAajhErz6ItznefoD+P9Cr7WdpXBUE7aBC5pA==
X-YMail-OSG: 2xiqf.cVM1lnvOJp.YssY2sqnMttmHvcJdNiSN_1qoGocSOF.d0okYWNCsbonx9
 ozDyuEEapF6FcWVmd0C24Ql5cFeEvDFf6sxtFSlJCXLWj7DPH5dcNJowUXEY_Mhtoi.Wpv6v0UGV
 C.0RvG5zNnUXgkky3Z0q9svDH7NPqde40BZB4eaWC9BShMfrtIQnsg8C6k.VkaFsg8I3b6UhgrBF
 jpoAALqV3TuCun2KoprN_rXfztyjTPulbYitvPYdO3f4KqCaLy5UouC11HXRkrUVkAx8ll3T_4KD
 GXi8R3Rp2df7HHh8IjgSro4bShMSV3t7qOy4_cZcLfYhWcTQCmX3x25zzUVkPwg7KUKuzYNnA7nQ
 5T1A2AbSk1IThdaxBp6iP.FqPutwLqgVgFeSP_rx.W.oiYimzC7_dFSBSGhPNNLUi3GocSZvqUOj
 w8OYj8VzWDZNP3YBB3i2jdI6Yak1jJSlBqLaBxvokVM_9WZRNKXdXPGkF2qBZxoiMqCCu4ZnvL2Z
 dZKUFAuYFI2vkhUAxLVXPsjefCDJzcLB9vEh0c.Rjn5By78t3OF10qahxpeOgOw.njJxYEk2VXA6
 BFdPcJzfCHLVe7xetAW_dWkCIbpXZpyJ930EywVPFMITGCVz7mKY66QZKl6eXXHrePt_rh0bLTuW
 uW.4wZgYyZW.f.6yg37uC2dMvog3UhyoXHO3yiXkZoxBZKAXOzlmKXs1DKqbzLsNXmKzrbmEAUQY
 DLcN0lgGSr07mm6qUofyWXcQd50Hi8APyuB_mRJs.hbCBFyiFCuWYBZQ5dkHaB6165u_gyzkYZzq
 .7hs0nVehzQFxrvloulZrxHAvy9UsaMfTH.JwWTbLL4NK2KyivePI_vY7ak84Ca_hqH9tWv34giQ
 W.YwE4_GksNBTKNHPrjDl0KG1llWZuoMEzN8xgRoUTHl6_lgmW7lwOTPRFPJ8gbroJotTu_4LxAU
 2Do1TtcCo2Qw2.iFyiUZkW8DAwvT1hn6P5vpDyK2ThXh6pDwFCyPOtnJ9DDVS0cdRtKCuEVzATf7
 hqGZw40yEvDTdiUvOiu7CS2PRLKPDCZvm6E3yqCkQ6lGnfiVAlLQxeY.GbBSb1cqDosR6VAj.eyV
 maFv5JkR93Djyny9akcVGBYnhJkJ9o5SS8MEM9sa9PZAUhE.vEjdPoh8zQrjmGGE4bh5mfEhVQbi
 IjtnqvpqIsnJAHEiFfxtVXUD.FpOR.A73RtLuDh36l1PyHKuH3szdsKPtdH769qMp3tP3g3oLJcK
 x6WmzekABFmFrUlBuUaXTwDjzkLUmQ5PQ9otRj5zDM9bpz4TOoMQAD54_cV9xHGtjcwxs.4ESuMD
 s54xybmIIKRoiHpzJchVlV2ii1yxxx624MdmHC3a909BHAusHnhikaiT3fvCeC4U5Mnee7lSp9yj
 BVmQoufBJFMBNc.j3dA1u8eYhP6Rwe1eMZ4z.j.X3ees9L4pBIqx2tMh0KGbChKQXyXUsrjbrAuO
 uytZvYHV2D5n5kR_6NcKoVU1NA7_ZhxeX2i.96BvRONPAB7sdxQmiLmM.bQHDhd04C0jcjKuTKph
 3c2N4CYRQwurNFs7MD73ZUWed9JfBEO_jua6dzY4fPAN.ANGhXxKOt4WiZ_JTa7stokEjLaJdtSX
 h53_ddgxL4pj2S6Xl9lxTL2EHG_zMDrj4DCXORXxrI6gqSNYQULDwUVZvS51qZvPiPl.CoHOCl.P
 xkFP8vKVbzKpE0X29QFUsWENyqQjQ_yDTvNX0FLgdWqIaWfA5QR7FxTEAtPmNmhBWsr5RSFkM29o
 INyD23VQTiiHHnz1L.T4NZk0usXL1QZzUCTKWOIKPL8qhGHtDfbLmpG8tg4OpMCBywdMJbQimksY
 5JjvxsTzw8Benk6gfxax37Sdgkq5vIpTt.lnHqoS3z1FlZXITFSAv1ceG5xfnXj5z_rpcebiX4eP
 FB1MZCuat4cNOhQSkszJhsjE8xIn_9lNAp3nSTdVTg5PW9GvsBNmXqHH1boow48bSva5xsn0rabY
 guMXvrN0zAG6sghAJ8P3HS8E.FviCOZP4Pg--
X-Sonic-MF: <tomasz.unger@yahoo.pl>
X-Sonic-ID: f54cd00e-3367-4f5a-b5c9-e5b87e00e58f
Received: from sonic.gate.mail.ne1.yahoo.com by mail-asdoutdeli-p-cin-euwe1-prod-sonicconsumer-svc-102 with HTTP; Wed, 11 Nov 2026 21:17:29 +0000
Received: from dip196.lsn.ir2.yahoo.com ([87.248.99.205])
          by hello (SMTP) with SMTP ID 8692ef5179a07c2da106afbe2bec9893;
          Wed, 11 Nov 2026 21:17:24 +0000 (UTC)
From: Tomasz Unger <tomasz.unger@yahoo.pl>
To: Sebastian Bockholt <sebastian.bockholt@bevuta.com>
Cc: linux-security-module@vger.kernel.org,
	paul@paul-moore.com,
	casey@schaufler-ca.com,
	serge@hallyn.com,
	jmorris@namei.org,
	audit@vger.kernel.org,
	John Johansen <john.johansen@canonical.com>
Subject: Re: [PATCH] LSM: check if lsmprop_to_secctx call is supported by LSM
Date: Wed, 11 Nov 2026 22:17:22 +0100
Message-ID: <20261111211722.69639-1-tomasz.unger@yahoo.pl>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20260619171945.1617498-1-sebastian.bockholt@mail.networkname.de>
References: <20260619171945.1617498-1-sebastian.bockholt@mail.networkname.de>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 19 Jun 2026 19:19:45 +0200, Sebastian Bockholt wrote:
> In include/linux/lsm_hook_defs.h, lsmprop_to_secctx is defined with
> a default return value of -EOPNOTSUPP.
> The function bpf_lsm_lsmprop_to_secctx, defined in
> security/bpf/hooks.c, returns the hook's default value. Therefore,
> directly returning the result of the bpf_lsm_lsmprop_to_secctx call
> propagates an unchecked EOPNOTSUPP error.

[...]

> -		return scall->hl->hook.lsmprop_to_secctx(prop, cp);
> +		error = scall->hl->hook.lsmprop_to_secctx(prop, cp);
> +		if (error == -EOPNOTSUPP)
> +			continue;
> +		return error;

Hi,

I ran into the same problem independently and would like to revive this
patch. It fixes a regression that is still present in v7.4-rc2, in
next-20261111 and in the current audit and lsm dev branches.

Symptom

On an Arch Linux system (7.2.15, AppArmor and auditd active, LSM order
"capability,landlock,lockdown,yama,bpf,apparmor") the log is flooded with

  audit: error in audit_log_subj_ctx

about five times per sudo invocation, and the affected audit records are
emitted without their subj= field. No BPF LSM program is loaded. It is
enough that CONFIG_BPF_LSM is built in and "bpf" is listed before the LSM
that provides security contexts. So this is not only log noise: audit
records silently lose the subject label.

Cause

Before commit a59076f2669e ("lsm: security_lsmblob_to_secctx module
selection") security_lsmprop_to_secctx() used call_int_hook(), which
skips a hook that returns the hook's default value. Since that commit
the function returns the result of the first registered hook when it is
called with LSM_ID_UNDEF. The BPF LSM registers a stub for every hook,
and the stub returns the default, -EOPNOTSUPP, so the LSM that really
provides the context is never asked. audit_log_subj_ctx(),
audit_log_obj_ctx() and the AUDIT_SIGNAL_INFO handler all pass
LSM_ID_UNDEF. On the affected system a kretprobe shows
bpf_lsm_lsmprop_to_secctx() returning -95 and
apparmor_lsmprop_to_secctx() never being called.

The patch restores the old behaviour for this case, so I think it is a
fix for the commit above rather than a step towards BPF supporting
security contexts.

Testing

I applied the patch on top of 067c5c24cef2 (v7.4-rc2-92), where it
applies with an offset only, and booted the kernel in QEMU with audit=1,
without and with the patch. A write to /proc/self/loginuid was used to
generate AUDIT_LOGIN and AUDIT_SYSCALL records. No LSM policy was
loaded.

  lsm=            without the patch        with the patch
  bpf,apparmor    error, no subj=          subj=unconfined
  apparmor,bpf    subj=unconfined          subj=unconfined
  bpf,selinux     error, no subj=          subj=kernel
  bpf,smack       error, no subj=          subj=_

With the patch there is no "error in audit_log_subj_ctx" message in any
of the four configurations, including the netlabel records logged during
boot. The problem is therefore not specific to AppArmor: SELinux and
Smack are affected in the same way when bpf comes first.

Not covered by this test: the obj= path (audit_log_obj_ctx()) and
AUDIT_SIGNAL_INFO. They use the same call, but no such record was
generated here.

The analysis and the QEMU runs were done with the help of an assistant
(Claude Code). I checked the logs and the results myself.

Suggestions for the commit message

  - mention the audit symptom ("error in audit_log_subj_ctx", missing
    subj=) so that people who hit it can find the fix,
  - add
      Fixes: a59076f2669e ("lsm: security_lsmblob_to_secctx module selection")
    The commit is in v6.18-rc1, so this probably also wants to go to
    stable.

Sebastian, do you plan to send a v2? If you do not have the time, I can
resend the patch with your authorship kept and the description extended
as above.

Tested-by: Tomasz Unger <tomasz.unger@yahoo.pl>
