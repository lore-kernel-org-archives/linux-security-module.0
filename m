Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADADC4361B
	for <linux-security-module@archiver.kernel.org>; Fri, 18 Dec 2020 01:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2867923A59
	for <linux-security-module@archiver.kernel.org>; Fri, 18 Dec 2020 01:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730792AbgLRBNT (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 17 Dec 2020 20:13:19 -0500
Received: from sonic309-28.consmr.mail.ne1.yahoo.com ([66.163.184.154]:38279
        "EHLO sonic309-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730778AbgLRBNT (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 17 Dec 2020 20:13:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1608253953; bh=BoqTbvYyh9kCc3Jf2fe/CBBK49ZWnK6/OJjEPf0Yxuo=; h=To:Cc:From:Subject:Date:References:From:Subject; b=WSc8Kf6S+/zTv0zxdwkW2bVTEqnEn/nH7BqWFGHMz8kQ4fx/3thL3+CMYv5wb8Hw/YCwliASyloZy0J6tvoXhEIWrM7Le8P+zYlTC6BERDai6MWPV+begxmaNvjAiumw18PLsr9szOVA2w4N7668YsB3jJ99Sb96gIG+qYCM67rfmCw74PUOlqCqGNCA/sHR/WamxZYVrzAGbzB7jla35BjAmqeZ+fDAfswjtZSMPvj3a7GJCCaFvtD9jO4EeManaGfgrctmdG3mINjgN69nldJYZaH+UXwzx8Pio4ZN85w95/FhUx3jCodelR/hnz2D6bBYi7snzXsSWgM9UuqSGA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1608253953; bh=/3F6lL1dFkTZHqrv3i4dCFcbnRjiU85a3dIXOupC3Ey=; h=To:From:Subject:Date:From:Subject; b=iI4Dyhb8FL6voDlUi3Z2SVal118CgfKB0tMM0u8U61CAX/oBQku1hoHoy8qlLZiC51gJNkPkCOM0NJ758p+nKOwxrYNrB1xziONsJMxow/GX2byBsYUX/yki0o+9acu4uEVUBq4NVumdtZRwKdHLC+Kp80D84Xks2vojQHAD72Vl0RcCSzh9L6T/J09Tikcn/RgHLV+QmPBJkP+OKEOrH/HC9HXwAaVCaUQCKGJeKSepqZoSUG90xrdoAOm/K4zohfybstMO/R3YYF8I6LJEGmiEIN186xVTSUMdckOqyS4+Em+uYOPXJxJf5+IY5If4SKYmD6oWSt9XS2QgHjs4xA==
X-YMail-OSG: wvnUvMIVM1mH_pe2RR_f8t8YuIa5CeuxtPUP5kq3sijlnHqHdY6WHPgwwGi5C_T
 ifQ56hxoarS0isDyvqk4YX_t4mdP9gfxKZznx3pQMcWBHGahTJex5T1LuV5vBo6l0jwYQzJLqNL1
 m4gaD7uZ2r9hyXKvCQWO7Z1GTVY1MZrG5vlCtJx3x.PCvLyNXKbWe6oGFVhZSjThPtx43mpqlxzR
 ml2rI7dSgM_x_Qq5nDiGBuyIhcg3qsWbPXo8VdP9uCJteq7j3jcSnfMxYz4nUg5g7bXLi9NAZ5M8
 i9LPOdFZctXcgw7_zipTtXRr8hW6CXwulxc7QmSZU_XrdNmoQvUY2.a_hGy8LH1W_VgSRvhBycHD
 _XosGaDHpCfDh8VcyRIpzvWXP16A7I7LBDW6j40.byRJVcDfnfrHYB8cZ4pMb_r5ZSqBQe2fEylJ
 EgZihrCSDR7j6my9A09IvmIyi6uwZlYxpd_EFB_9Hk6o0jetDuqpN84QtfRhEfntWWMT0aexRyOF
 UOQZKfbhUpSsyIFhyYngo7nRiYxY2fPhsr3tAzU.MAvldSXuAmDuABGFegFmtmlIShB1SahqHJs4
 NiCH17R5bjhaGkLbYA_Mo4AJl0UTsiTwT6xevz2UMEXTSvaoBmyxsyGMc2BOJ5rAPBxGY0zFtqNE
 Oq8xhnf9CS_ysDrXnTyrPDQ.v8Keb_GGz5_Z6P0ANQXMwBJIb_gQ2eVqhvPhcJInGOmzFqHS6iVd
 Ja45vyMfDfP0dSg0sakfY52kj.TKQoilz316UjZjGW5pbRROXKaQOb7PI_oqchFTyptmsxzzT2de
 9tZFcr10XPoE2zTswBYIwSEg9YiS3Z6QnaTFaZ1Ln_B8dWJrQeuS.Pc4NQ5ll3ATmhWa0YxAraJv
 .yvSNciARy.tU2JzXte93nr0nwvPCz0JQzSc5WdkbFxU4WCsCZ0uDLMn4TFK8JsckXabouWCH6QJ
 kf6ZG5xE_qEJWIrWQPz9O9ZTSUl3TC4vfH.eVxlt_CWIkQ8lYQvKyLPkGQl_5nDj7vTqIXZEBhMT
 l39Ffdlrvj9_VHB7t1Zv.jtWLhAxt59uGupEDIw2U2BmmswR7TM_ZFsze5MCB_A2ZFYUMbZMEc16
 sDzMrMamwWX6_3SsODdfelSOZL4rk74JjtLU8_aqwdSi9kw_soH_DoGkBi1pWBh1y58JDdMdZY9V
 J1sEk21J1BznSCti1AokVnLiwxHqnAMNMdqXPex30d_a9oi8OjJIEpCmvIoSFOc6EBySrIA93IZi
 .JI2VS0CGrz5w5CKxC60G8LkhY_p024Nb8w_yQH.jxDzHkk21CD9B7IkOGLWodqs_T0upJbUZXNI
 E1y7JZlu89FixmPyr0a9Ds62H7_hA.3rwOMZRoGS1L0NoF_vz7eMCeNNVhkQiTcsKIHjFKSjLUw3
 ks62PQgGgIhHY_vZcy14hsy8AJNfPasA7n4gkNiuSiWGsIj3n_yS9NSrWFjZqSQOmS1EGpZRErwP
 wonHBknotkXQGDize3KRty_I4_RsqSl29YMEu26ukiG7sjosw.Ei9Cqt_8DXaJ5hUCJyWUrPOqpp
 UyK_Z_SjC4.uHlLPEGY0VmzjoAc.295x5_2ZteH8is5BgF4UKMFJ_5_qLCWq17PT_9GUM9pOaXjA
 br7uPCaH7hQD1eBjpGtklUeDl9PjxZmr0WpvQKtL9MRuzcwLURSmIQlqohO.of.YKd2d0eASBAVd
 P.Lg.XzeRJy48AMaW6htceq0Btwe_3IQusnRUKqzRSXBLFU99QrRGdoTAPundSS_lU7QNoL6DN4O
 j.5ttKEmmVpjtQl9.oa4ZJB0_yQu__esASgQokgDrW6bU7hck8vVvWxLtrv36650hxjirSrSo3rd
 9B3yTppP7dlWrfzUhEqtFHvwna1D2y3a2m4ogjcJTruTpTmCFcSQ8udD35qClMsGLG0igvW7uGSJ
 3CRSnn.w_XQcVDUtJv6bWVGq6ewsYo621lz4u0JSy1o71lVP8Easv3aZFGlyW1WXPQpYIgiQ3jrQ
 TS9A8TqyKkT6CeCQ_fYGE5BeWEunnN07aTy1cCVnZN2lB07mNvYh33UIjWDMPxsD9Khkx4CH5xxd
 _Sz.j7uEjX_tlYWoSoIWSMZGEyvMLTS08mBtZTcIJDg5Mppi5w0qwTDSzpfP_Xp9PyXMt27wGYHI
 1HCw27dxEc7jdKFXdvDqDFiLqZUGYu9hNml5H1O_Df9WIjiMQD13Pmxhrg8xxBLEhX0Zda2_wVHq
 dprYiHeDQa8IxtpzqrMSrnbF25iUbyFLMtDObLi3ehb6.V7wETqvrhFn4C7N4vCBY8aA.BcyqbsD
 Z4BO.YuGb5l0yDUxspVZqkk06M4MNJI8.UV3iaRrhVQSXv815w.rA0on5R1D7cPHJBAj1iKgLls8
 X_VuQ7E8Iztilu4IPvvaEqKXnwp6uy3ENJkG3RLwfG4LvHMQ6HzTEMr0QzB90vcFqax2xOUPrEQP
 9Bt.Z2dFD2HJgQYS.2OtgSRscxQAAdh6ISWffU7tm50Ti7EVOwwWqMUm1ecK9_wi2SsjDeScelxs
 yORITezQcvqIa8OUTg6y0CTmw_EjiwTC8TlPqOYsBIcgDP_ILgtf.tZ86lyw04zS0bBJD_17v1FJ
 WMGsAgwzyfcCJ8wYvqfjuW_NNaBYbMC387aYiHFxY8r_iEz8_MwO3WWM4KuGcTEcSngIK8kJuCvT
 wxxQIFcybnHKHtOBdSbYgfDICzMJOQ3bEe54Ao5jrRwTIk2cOUFN2PLwQvoMTG0J86wy4vhsGAxR
 2NtDBgwB67425c6uTTQpw7Yl84T9FmKVp
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Fri, 18 Dec 2020 01:12:33 +0000
Received: by smtp416.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID f6b4219fc7d55273212009d95167a10a;
          Fri, 18 Dec 2020 01:12:30 +0000 (UTC)
To:     "SMACK-discuss@lists.01.org" <SMACK-discuss@lists.01.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        LKML <linux-kernel@vger.kernel.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
Subject: [PATCH] Smack: Handle io_uring kernel thread privileges.
Message-ID: <dacfb329-de66-d0cf-dcf9-f030ea1370de@schaufler-ca.com>
Date:   Thu, 17 Dec 2020 17:12:29 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
References: <dacfb329-de66-d0cf-dcf9-f030ea1370de.ref@schaufler-ca.com>
X-Mailer: WebService/1.1.17278 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.8)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Smack assumes that kernel threads are privileged for smackfs
operations. This was necessary because the credential of the
kernel thread was not related to a user operation. With io_uring
the credential does reflect a user's rights and can be used.

Suggested-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
=C2=A0security/smack/smack_access.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/security/smack/smack_access.c b/security/smack/smack_access.=
c
index efe2406a3960..7eabb448acab 100644
--- a/security/smack/smack_access.c
+++ b/security/smack/smack_access.c
@@ -688,9 +688,10 @@ bool smack_privileged_cred(int cap, const struct cre=
d *cred)
 bool smack_privileged(int cap)
 {
 	/*
-	 * All kernel tasks are privileged
+	 * Kernel threads may not have credentials we can use.
+	 * The io_uring kernel threads do have reliable credentials.
 	 */
-	if (unlikely(current->flags & PF_KTHREAD))
+	if ((current->flags & (PF_KTHREAD | PF_IO_WORKER)) =3D=3D PF_KTHREAD)
 		return true;
=20
 	return smack_privileged_cred(cap, current_cred());


