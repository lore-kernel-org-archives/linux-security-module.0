Received: from sonic316-26.consmr.mail.ne1.yahoo.com (sonic316-26.consmr.mail.ne1.yahoo.com [66.163.187.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1D62575A
	for <linux-security-module@vger.kernel.org>; Wed,  5 Jun 2024 17:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717607523; cv=none; b=Uys1gUMwXPiRwX0V9p4bhKBYHqtGJ6RfB5BzMqqDs7R81HH2Oj1QZPT3bRZ+FAqpxBAjWfDXyLEtk4N9VRAazk0RMvaX52LKTi8FMNnQpP8gZbkj+l3w/erZ+NDfBiAsnMyD+PnEUm6PE+KmFrDbfopzgKLgCEjyFxmZlDIG3jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717607523; c=relaxed/simple;
	bh=/PNuujJFh9VqncFAp/ets+NCzadmx8tL0t6lS3a78cM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j4B2sMgcOrTL/M5piMfvrno5At7eqCJq5BoWuS+52DF6OUrPUDrKPNvdtPtRIJkbXAFGJFgRAgJl0kj2RVEubkWO/+wzuAUsq9lr2ZjJdDaVvQpgZzakVnu+GM8jYrIYvt8HXsiDCGWq6d9BDfaTMMPiqVkuJehwYxVio8IkYjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=EJT1xgTP; arc=none smtp.client-ip=66.163.187.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="EJT1xgTP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1717607519; bh=spia9CfPBRawlPILH+KGHi4AdnaSo4b6C17kdWnc1LM=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=EJT1xgTPDrMh/bqTSk6mgpVUaHKvM9/f4z+n5WinN1pgjLU3k8HfxsWKKY2T6EHXeil0TmApdZTrCc6k75af5lQaorg4bSjN1F7FPd4XR/Xiw/sygSd8VDNYKySf8kjdwBAc9DztUgvNsYy2ev1he9neV1ofPWAKkTh6uu+ETcua4X6QMKUnBxakjS1tVW7raWJiLoy6bUx3J8m7zUFoS/gGXVdYBPFQdrDaLqEaKqJZfyiW+Jx8jzBNRgGDuO2JoyjtgbcwUxuBtNu5xW3OCGAt9nSzekvPC552/z1ZuTMQ6giGjQiQ5Lg+zaLsPOtCHhq0jcHFDP24E4Gj0YqzpA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1717607519; bh=+5MJXDmjEWdbqrcm1fpS7517ljcdhturn3W2wS/Jpeb=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=DF3eZrEGxFArZMRAGrld7SddA7fRnHr7mUutqeprm1aRP0xdoR0SYv42GpK1Vz3fh0O/L4bfjMa5xPwVm8vwiDQkTLNobTuCZtVBbb2lB0lCFKhvlJeN91dvbxrQMlievDyhHKiKORoIC2lBVNlAvDwlOhQKNKFpTzw3uiDKTJYLYw7pMUikknIR2jgExVmsoMtpwqpMh2DhPool9BXy/FPaHBMvWhkeF/dW3btLURUwnwPmZNxqthXAJQ7D++oqG63L5n0EFhqCtztRbYbkZQWRuiZk5gMcYeoE6Id1huKv3AtiiNXfmAbl3CcHMK1Wc1DH0mlj1dnDNNUYWFnzMA==
X-YMail-OSG: cK9rUA4VM1lvRgYIKyOcnRlIDM_dHTr7YlUIzPYkD6MsPDSLBVgb461Gk7TfSjO
 XjOIj_o4wpr8d7hXPdqsF_V53xdCbxTuRGnsODNNhVVlxDuCtDvqUhmn_dM34iXnUQBiuBmBHGq8
 DGdJ6R6DB19svaI69sr3k8g6dA7o4OxWuttCk0cD3n07cWK4pXOqDE5PjjINA48lIPwoyajc20Ow
 2QHodF4e_mRYodCDacfa.jXpPhmSdbwgubRendG9Nj3CU0tO.B68KMLwX1yN0gM_3.mfycFgwh_9
 jz6kHK7XtWLv4KziPbhoXcAazEYNYMccJKO8_Ww1IDO7DZ6qgGDGhcp9vSzmY1dmapxnMRq4RWXc
 xnmsa4uHiG4CxCmcmOQ6.e6HTLWCszVhsZ0CQdXXlM2Y2LogdKGB_VcRH9EkZ.AiYkdn4q7p786n
 oEiq4SS2TU_zUVMqPM9GZvlCIoMeoQvlpireaKbM0b2bX8p2IfGbwdue2VjN8EDjymVjx3y3L_Fp
 Dx1rBYTy8.0wYbT6h03y_BeUK3eTarCXIlniaiinNKDhY8yPmr7wU5jWI1TIdnxxwctydi8gT60n
 BUs30L5zlVNVu9ZKlFEkDCzCVrk0GQT_SKNJX2aT8wQtad4axoKUqa8AqgWQDHr79Jae9UdUZrzT
 okMFsOZVZITjmPaKdq_MVBKAJi3HZ31FvqfyAp9MVpznv9tNly6QFqgB0dDtVDx3NG__21Qc5c1M
 xVPkSllYk_M1ML0H6clNAQ36cES5NtOclC6G2X0imTGjLOFW3743E93OXG0qtTAoTH6QxIbmlteC
 TQCHdxV_JgzyTGCPdRz1o2O_pNIbuv.iwTswL2B7PRmHS_hQRNzzYcZQG3Dj8E3fljopY9hELCeP
 ha9nKc51iGSWrSXcjwQ8mUbmt.9dLwnplOS5pGlLsdm4kTKQBCuBgUxchQHwNt2CjfVhCZ6SU34g
 .GTi8uY9AFXGP.SB283YB60zlICNzXs4WZmXjSDp.impG0EFes0vBOseB3Fh7PhW5g_Mx6_cgAGn
 RyL7z_eJ8mwHp4dv2ZQ_DU4qmH3Ba6TGL9Uq2IsggnhKGqRI48xzjBHA.6112yR49Jc..jFZg.Tz
 sStEmteYFdRnmZHo9K6VJ5RoBHzxrEuCIPtja.RheoWW3HTXSAU5GDZEp5tOOZcoPhxgxH6jSF4a
 H9dX2kEqP1PSd4e4YOuwKRb3TQK9Yilsv7N.EPey0RB0BKjanKe7H5mpS4BAE74OXNQBQw02SsC9
 nSFuml5L.7jqqpMSSIsiG7FDFniAYNXPRGkZjs3JlsOTTL6NsNSrJD_u5iSSS5dZ_6vSt7R6sHw3
 H5_6ek4pLCGvKc.Kzd3IeRCjoP8NGgj8XR3jpmLap.bp2XV2htn.qGnLh_y6hEeSRY7HFatMWR6i
 aUavKepGr0olIQfdnkneTB0S8BdAbV5AGTMJcfbCc.qTeVggS6ONNVYK8j3J4Fq9QUCd5mfPuInp
 S31MuUiiifjwvjLBRjBYzqRa03DUgrihXGIz2UAEddbyyoM2d9ojfRf50K82mHiqmafJ8vRM3l5_
 QcIiMHVPLPG8wJCAmWG5UtMoLslj7Ho83VcPfgYYbnp2ZLEryzgM8b5fD9HCJ.nwFfnDwRDquOTp
 a7YY4GCyJlef7Rq1wKhTMbCWz2qgyiWchBEhx1n8jehkBltL3MpnXsfxqoxOdkaNvRAk1zb1HZ7_
 wAeqVJ0FMYhRx2BtZowczJK1JMKxTtJwqUga0_2Fyr34YnRPHC5xw6txgsZIgjGVfVPcQiNld0zr
 6FBIlvCevqd_kEzhhSEk8fbk3ZD7M0Y5nK078YqfoT3iwJJOswuVqERehYR7hxuV0ujgmZ3zfwUD
 HTbH8bOynLT2Hp6ivzwf0uL6.Ma8IxjVWyl8SSuAFDfnP4khpEupyvV.r8upqRMmCSbQJMqWw7wn
 zwebjtP0oEjKC.y3Y0VOzwlaC5yePCRMLxBHOPeDN7TzT7QqRJGx8tyWnIX00j2ULbkp3fXp_UsR
 3DkvgW4X7gZZkeH2gI_hZR5toltR0Q5ME9kNXtoONIWM0cnTV7T.ALUkzwtZ5Eo5FQlJ0KXT7hiJ
 A5i0Ento09Glw7IRAMcBClj.Xrb5dXDJU1HxkenW70NO7E7nTRK4hXgoEatlj.fIuO3h9QhA4L3n
 1I6nyZlcJhPtd.bsnq_cDrmbC035Jwf6fvU_I2sIOZQhBMzBxl.Tk7w2kSsRUq2X4cYjDEbs8CvM
 Oi84YWKhNiIqMNJRzxyHVJydPWatW0uQP54ISExP8m_mV_acYPGgwJPomS9DNiROMkI3mqBQz5XM
 -
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 2f8f7982-6794-4938-988f-90642b6b8a6f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Wed, 5 Jun 2024 17:11:59 +0000
Received: by hermes--production-gq1-59c575df44-cc288 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b69e2e6cd9bd691a317edceaca05248a;
          Wed, 05 Jun 2024 16:51:43 +0000 (UTC)
Message-ID: <8d3abd0f-065f-4bc8-b0d1-6d47b7ba2489@schaufler-ca.com>
Date: Wed, 5 Jun 2024 09:51:41 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] smack: tcp: ipv4, fix incorrect labeling and unauthorized
 writes
To: Konstantin Andreev <andreev@swemel.ru>,
 linux-security-module@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <39aba268-8341-4644-9d70-71ed91c7525f@swemel.ru>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <39aba268-8341-4644-9d70-71ed91c7525f@swemel.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22407 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 6/2/2024 5:06 AM, Konstantin Andreev wrote:
> Currently, Smack mirrors the label of incoming tcp/ipv4 connections:
> when a label 'foo' connects to a label 'bar' with tcp/ipv4,
> 'foo' always gets 'foo' in returned ipv4 packets. So,
> 1) returned packets are incorrectly labeled ('foo' instead of 'bar')
> 2) 'bar' can write to 'foo' without being authorized to write.
>
> Here is a scenario how to see this:
>
> * Take two machines, let's call them C and S,
>   with active Smack in the default state
>   (no settings, no rules, no labeled hosts, only builtin labels)
>
> * At S, add Smack rule 'foo bar w'
>   (labels 'foo' and 'bar' are instantiated at S at this moment)
>
> * At S, at label 'bar', launch a program
>   that listens for incoming tcp/ipv4 connections
>
> * From C, at label 'foo', connect to the listener at S.
>   (label 'foo' is instantiated at C at this moment)
>   Connection succeedes and works.
>
> * Send some data in both directions.
> * Collect network traffic of this connection.
>
> All packets in both directions are labeled with the CIPSO
> of the label 'foo'. Hence, label 'bar' writes to 'foo' without
> being authorized, and even without ever being known at C.
>
> If anybody cares: exactly the same happens with DCCP.
>
> This behavior 1st manifested in release 2.6.29.4 (see Fixes below)
> and it looks unintentional. At least, no explanation was provided.
>
> I changed returned packes label into the 'bar',
> to bring it into line with the Smack documentation claims.
>
> Fixes: 6c3823bc3abf ("smack: Set the proper NetLabel security
> attributes for connection requests")
> Signed-off-by: Konstantin Andreev <andreev@swemel.ru>

I've verified the issue and your fix. Responding with the outbound
label from the socket is the correct thing to do. It introduces an
inconvenient situation, where the connection hangs and times out on
the client end. The connection isn't refused, but the reply never
gets to the client socket because access is denied. There needs to
be a change on the receiving end to address this part of the handshake.

Nonetheless, I'm taking this in smack-next. Thank you.

> ---
> The patch is against branch smack-for-6.9 at
> https://github.com/cschaufler/smack-next
> The hash 6c3823bc3abf is against
> git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
> The commit 6c3823bc3abf is based on 07feee8f812f, which is available
> at `smack-next' repo,
> but 6c3823bc3abf has much narrower scope, so I point at it, not
> 07feee8f812f.
> This fix passed `Smack kernel test suite'
> https://github.com/smack-team/smack-testsuite.git
>
>  security/smack/smack_lsm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index b18b50232947..d836ca61e081 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -4428,7 +4428,7 @@ static int smack_inet_conn_request(const struct
> sock *sk, struct sk_buff *skb,
>      rcu_read_unlock();
>
>      if (hskp == NULL)
> -        rc = netlbl_req_setattr(req, &skp->smk_netlabel);
> +        rc = netlbl_req_setattr(req, &ssp->smk_out->smk_netlabel);
>      else
>          netlbl_req_delattr(req);
>
> -- 
> 2.40.1
