Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA32212FAE
	for <linux-security-module@vger.kernel.org>; Fri,  6 Dec 2024 22:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733525841; cv=none; b=bASVii0SpjGrJKFxWNrOIHV5ezNJW+tx3X4XDbvnXmrKZFrA/W9IWPiLA6ZUCjl9FoLEYe+Hmh2tjl6qHdeOn2jZsmu7kLIM94QKj0yUSxPLO6jR1XLrQCebY5+O2SYp0RaqNMMepM3ZvAcFUqU52C+CW+VHmjd2oZM1mEupNIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733525841; c=relaxed/simple;
	bh=ASt7Cgv6XdAlZwm7aOfOExyBnnvrBS3mvDlHdJywV6I=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type:
	 References; b=QzPRFL39Ipx87z9bXob2Wc5E9rGjr7IgD/hBfN4+0mE80a0chf4+1/gJyuxLl90AKRqDHxb7nIK23ew1QhNdcgB24fwWAwxdtxmgjOM67MG/e5KV9TB6rtgnhSiuwC0miVu4U4MZmL1AO2RgWktq0tLbrdkAwwGQzrFac4hSj2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=JDkB5rOi; arc=none smtp.client-ip=66.163.184.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="JDkB5rOi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1733525838; bh=G/7nMyzlsg2sBwRN5EeArLXNy30CZExU2DL1SPNUXcE=; h=Date:To:Cc:From:Subject:References:From:Subject:Reply-To; b=JDkB5rOibCwgXW+t8Kcs1LmRCNbdPlyR3mlRMy6DVtlN/5B9xF02r3wOJMQ5WIDJgUpUJLJQHwnskXXRmBVr/ea/3qTHaQSo/k0dHm2F0VCyHZ/mdYYl9CIj2CAnaKdSm1uGVw5NJavS1mQiAEy72YKNKJ7Ku8B/Sx7dEjEwZCCyvmfCRuBqYG641S/gPcdDjqqvxUhplqd8zABC5B0F7i8JiB3ldwNHiVgvFluWojBGbsViBjy0AU9WOztNIO+/Q82UUU7uS7khTv5wk+WbcH5vGshpEgd8vMS6bM6qc9LRwiGdmwy6nF9jLKlkDg/TlS35ZnAbQUjek5GY2JfpSA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1733525838; bh=Zl3HdiF1+sY6+6Fu1scUH9xObdmhF7NjRzL4XpI+nba=; h=X-Sonic-MF:Date:To:From:Subject:From:Subject; b=IRTizswLNkYuGKh9h1nYUGEu8Ml2DuA1i/xKKLFp4GLwh7L66QrEu1JrwZ19YIFLypNLj7xTExVx3TxCe0KOVnVE8l85tCpluPShtc72KIlV4b31JYrYKoV78r5J7P4KT2MMO91O9mufaExZ+omgInfxDLntAPu6Wb9Qu476yY5I3n8tQrzvt2YK6RPfBROeuAVMU4KPy91kw4UxM5Zm+CVJWATjArr90D3V9AmL7TBmVV88wHS6u/R0/bBPHBspPL3aIUQl4omDFrntk/6V3rbechjldI/m6j92BfPkWJgp+BzqmLPUYDgaBqiWo/fhuZ56O0aBBmllZALrCO+wjA==
X-YMail-OSG: Iy3P.KcVM1mFZqf7UW0OqFR9DYj5ns2q6klL84Rra9k0g.oX9epjvxP2PTXzVND
 mcdBUwr9EZJoiPoWzE3c5TAISb0sreHkqRIbGcVuGdOVLe7X4jEwNRY68jNpgFhCNOaE3x138ylP
 ZLbjuGLdKnDTbDqVfmjAS6iIT9UDgCO9P9V4qw5siJ0bbBa2GFN838PlnAd30aYXrkGiTZaFfbO1
 KNcSppK4xUUX6ABHRyVj3c_nSw4iV1CBfJVE.nfP_oqkc9nltTuoM4zgEw..gYMXPjQaYLNTW6ez
 8TpGTN1gBKPQFrBB8h0C.BKw0GPAZC_9JWiKHq.1_7o7p2IWKyPZxeoUV5SPFGD6wm8j3SvIzciP
 SklWswCaiOxekD6V_IL.B0aYzYmPqt7bX0heil9qADmyWZnyqEktyaVBgw8zJIA81wj_qIOS3bRC
 auFgi7ke_LMZnN0BuBhFzsbRj7y_5iHVMxEn_iQejmkeBOjfXUQ0qFx3ci6nypke_fgTNtWQ2P2I
 JqGHHEmxWE_F85rdXzfh73WlIQ88XNEeGWD_9WNi5I3vrBt.CioPFJQJLCuPJEEuoo8jgCmwcloe
 2sfND6PooLApwhGWnG8ypqFYP1ULzHj8h4Q2ySxGuftqOmj0WPkyV_h0wa1v6lHsV5yeY1p.bxwb
 pbYCoJIG9sgzWE.fCkvpvZTppdLWyVRF6o7Q7jvTTfGWBhfYsNz7m7F5tcKf0fNESsckKtJ4n8zr
 NG2oL8bLdYL0CZ5Yu_xAJBVtutkwGjFSUeIq4O3xLEgHY.VMQQDv10zt8KZ6_QzqQv5I8BVU4yr8
 OeEox4Do3AAXbW7xvgIM89sJyZQvpYTdPcTblkdJtiRK6emyyWYKXL5dF5xJbYWbtVLXg_NGUJA.
 NMO0gXLomdo9sUTQ0QIBgMGB3BdNLGibfA5UgOiYpYE6mJH4v14WrFmwrf7Mw259z8m.edrIH1g7
 wjeDusDjzMxwftcR13VfyYA989ia6289OxwKuhMtSD5ebNjAMSGX3IL7e7sg7dg07rAwvo57ChSG
 JPE59DdRRRIjJwJIpSj3ziOVVWJvXpW.Z6fLhN97WKpO6qwxhwPptDES68ETX7t9dQmbj0LUfg8M
 ugbB8Nq48rzr14kLVUE9pOuqdwbkLJUYofDEbOKkOko6caI3QdMobsvXitRbRgwX7qHW2w25bnVw
 ZXyPo0lBKQb2KzoEmZ97DZAgXhN5U447LnghUkA0TE.oRQywjTGkEMzJc1rIQQn.FbslDw2TwyWk
 XUelbIq5FjpdnweKtPVdF0_stBXI7C2SWxHIq3Z65zE.D24JRTvFr4tpUV1b2dVqOJoacvbLhMYP
 uFV8lsy4oaAhqJlWdNMQCLZuN1gzrWVOGq.JwTFtjKVVHJanyLibEIayjHKjvuw6Oki1SVq3GsYY
 kVwYD_MRuFzGKvnAPsMChNW7uBBcS28A3rtQz8pVua_HCDqtv3jG7_FwNLCp5AOCKxVzWyE35xq_
 JS4k.9THZNQyMrsHDM.qhC4I7uh0Hs2kFgj1Sg_F_0Xc3V_ULrXhYhNeT_BDHVnwH3jd.uANcxv2
 mJWj1JNCLL7uB67MG8jdNKegylsrZBR5CA.B_p2OYtUYAjYuubjXngpHd6NasWHoKP6zW5fnTLdQ
 _VCiIytSOUembBBHYlFgrBXJs97yHaQte96s9BsDDsqQcEA9dek6K6gzaeiebtQnzBR8rebnFysr
 Z3edYNUxmKjpfsJ1FKnJcqNfTqyD3.zsOcnRH7OUYe5YwBPRQUE8WWDCwGZTqLVbUVaAerPMOEkr
 hxhxpl2.mkKSD9NR88pHSH17jdE64kRAa_BA8s1p7ckl8z10bg0IPE7XFmOtPWurJ0q_1p1lrW48
 SCIaZ141IbcEV0u..cLhIxGGrUEswLHVsGfGIBdNLpDowC6A6CsKp2Q1RHnMppzJUASJsMX5fYVQ
 q7FeByBVSyJdtbUDsWpDsNrTkUBxsI8.r_hAdWR4.clQTDphfqpS9QeAU.iaKFmNWCAiOTEk_t_6
 5ZPJnE8ttwxBCHOpwP.8Xz57tKpfK4IsOyDv6hpsZRrOpky5rQQHaYU2yQzWmFIk_LoB.CjlJpvC
 tTlmgJlErVYGjK.gQAJoyNF39EobHPmq6v.WbYAMyj7DgaTxhIno2WVgeEefL.w5ZAdbWivKSG4d
 oW8A5566dzj1TCNcZWX0iD_fMmTGRT2TQzYhfNO8nln308vUmd2oz3CKr0jxvgyz2JMXWdRViwD6
 41465eYhkVXsuyiW9yCXMGezaoMw7MUv1sFI_tIpZEQ92W31zA7pQqndgMfrwLi7XJVbF9W3rXyL
 f3_X8KcJpLI0SrZe6og--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 866a8ec4-8367-42e2-94b9-b6517faf2954
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Fri, 6 Dec 2024 22:57:18 +0000
Received: by hermes--production-gq1-5dd4b47f46-5kxd4 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a8e4e923736d38a0832402b2d700732d;
          Fri, 06 Dec 2024 22:57:15 +0000 (UTC)
Message-ID: <5859403e-905e-4307-9fc5-dcdc93f85cf2@schaufler-ca.com>
Date: Fri, 6 Dec 2024 14:57:13 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Paul Moore <paul@paul-moore.com>
Cc: LSM List <linux-security-module@vger.kernel.org>,
 Casey Schaufler <casey@schaufler-ca.com>, Kees Bakker <kees@ijzerbout.nl>,
 Todd Kjos <tkjos@google.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: [PATCH lsm/dev] Binder: Initialize lsm_context structure
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <5859403e-905e-4307-9fc5-dcdc93f85cf2.ref@schaufler-ca.com>
X-Mailer: WebService/1.1.23040 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

It is possible to reach the end of binder_transaction() without
having set lsmctx. As the variable value is checked there it needs
to be initialized.

Suggested-by: Kees Bakker <kees@ijzerbout.nl>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 drivers/android/binder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 919da8e674f5..a4b98e95ab85 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -3017,7 +3017,7 @@ static void binder_transaction(struct binder_proc *proc,
 	struct binder_context *context = proc->context;
 	int t_debug_id = atomic_inc_return(&binder_last_id);
 	ktime_t t_start_time = ktime_get();
-	struct lsm_context lsmctx;
+	struct lsm_context lsmctx = { };
 	struct list_head sgc_head;
 	struct list_head pf_head;
 	const void __user *user_buffer = (const void __user *)

