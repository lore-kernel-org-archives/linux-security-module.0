Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82ADEC433EF
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Oct 2021 19:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EA7E61154
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Oct 2021 19:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234876AbhJSTzi (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 19 Oct 2021 15:55:38 -0400
Received: from sonic309-27.consmr.mail.ne1.yahoo.com ([66.163.184.153]:42442
        "EHLO sonic309-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231355AbhJSTzh (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 Oct 2021 15:55:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1634673203; bh=LfYW3Z+rcYIBTifgCH7sWBJQvcpvijhLIxG8FhERmbA=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=LnbcWjyEyoVUimCgVvEMDArKC+r8x5mGv3ioZp/NsSbruJqE4tkfLbkPk/fsx7wIgb0Eh+HZRtCj2ruzRynrbXTzCzIRKho3+38z1yUxwKEmETsLogUWvFLAYeXDlEidXNcXJ//5UtKkw6k0tNARPjCoaz1WkJPyq5p85+bjAE7V460tevfRic2C/KxfgpSz6cP9vULKQcVGb5ASwIFzLxEUFV9sc1EN5/TgQOTHv2a2LQA2V3bDjwf+uyCon71p+PYbu6ieqKwQcBr0P6LoO1bRYDmlO/8GcyzfED5cXI+5hTtmylobDpLZHP1tJyz6KoWrLiVuEV02/FrEN/pnlQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1634673203; bh=xfjRX/X+PtMeOUPLT3Aiqwh0bTJiSqzM4HXqlwF+RUn=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=MYTMb2piE5iIrNTEXGsB3B5Atti7PuA84LGyP47MMT+65glpLPjfJZRcObsnvV1tXyaqx70jGEMJ/9HAClqGhnK8pyappmiLll8oxZtlKfU0i9BgwPm5XgWfO6LeaW/UEr14vl3HoV1I//ame+39oqsydiMvLA87MRFvSNRreJ+lyZDkUGNoJT3w2Qk5dj82wtzCxwH7o2v88LKUxilWypGxpnSdQKmMyIaixLlBpnCq69pVTtmaphMFswjYgJV3rDiJ69CntBHUlCXPLSRGvzT8+ojgMCOA93wquwyaD9032s1MfjSm3pJ97UMkfujA07lJKPtEHw1ywTGfNV+SwA==
X-YMail-OSG: F24JJaoVM1nzm3H8whxyuHv5PDta44pMAvxLlq5VNnPL_wK0wWjEy8kuB3bUEdb
 jy.w49Q.EebjnKOWFBntXK_wZRe.k.T8Ybyx.s40vQRZqLxuRMo7AwPwbrohzfz1zUjV5WTbQv4w
 aycVKfKWTIPdfdhmy.z07vJnH3P1Dj1dRN1ug5xeIgjgLka4j9x2REtCFYz7X.8rDhUUlyWbJfSr
 3H7HHXmCR5ndyrWrXJsDXxv78WgH033vcj1KW24PGfRpowjbJMvvw.nMOuIj9NtEctGCCDOL4gFT
 ioqwwaehwBb6E7AKhgbGUYAH3zVkmKbdFbP4aLVxYA.ZLj3SU1QKEgz7uIabMQPOGJ_wCuBBt9ol
 kKn0Uq8FiU9y7tJqdIz5MnqtpH_COWjOrOM3qzedQoPtIDxZO.fVFSSB7uxJksuHmEOnbpi0Bpmt
 dS4IaP0J7QDefxjeUhIqurCbKWN.ECrevpujAvlV3dqqOMu0rSH3OisanTocHk4OMLwIJaZrvWVZ
 fA2sf7xwjkaIpOC1EzBTQUbVsW08nHWjT_4hQ4b7qoPzstdoxu.gdsPpRTw0ZlSTr9Wt5uQzEQm3
 41e6c1wWGl7OA7L_mpBePSSFuGhvxeOqPeFwhilJXoagz_HAlY39fT3OJ0U6P59KmdDSxCtKcC4a
 f2SvLGn.J_asAhjNwbhFzbqeFQvjtR4jBzNMF8B05V7p6ssuZ86ahZ4PAlWstGE6s99iBRh6.Jts
 JzawP1RGTFjVrGR5E0B4I68m7II_yOYxm6c2Kstos9zvD5QyYYtlyhDZ6orJ1xBsHGQSRqypOGPu
 S4ggQRWksoYqSJrMrORDEdVSuhoyHAhcQcVrLpbt5cHcfjVu_mX3TTSIZI2stadrcI40CWdfAEuP
 JZauHi5sJteUJZDjvDjynAoQ9dnaoqJDY5Z_bhDwxUHBBEulnzHw20w6BCTAE4Yq8X8IHd5RZ_75
 jrsBSURmZHb88vtOnrg81ef5n5265EYbP87rNa0UqEkM7J2Ws5pfmSiNXLrjyFMGtoMRUkKDr5Zp
 2Pcysafcg.8tVFbHLMoYBXpHIxcUraGmJPNpXI_JNuYFdsXOy4ig11iKtlGhTC1qCcfg84U7NbIg
 3ktdIg33ag_1MkMywYDFvm1cA5r62B0c7VZ1EO4JsatOh34gIA6FVV4TN7t4Ql2VxdSs_m0ViTIJ
 W_c3om9AALz0ScmwFa3qg8dQM.dxbuoFodBix27i4PsMuuxZS5nqHwsnoc1a7wmWW0Q1zxYcKPfj
 InVmne4Qn8hS_yJDpgj_OWLNx8PbrXo0JaHyPg8vXo2UiKP7LKOzZ5hec.bcBn8Dmh6rzV3KxmNl
 V4VPdNYZwTySKt.230_DQsu9IBoy.op214xQ.721Vk_eY.UNZCnrn5b6xXfRl0rEOMFGd3Xr3yvm
 6qYbNm_82hVrD2Bn19yFGkT4t3z3XHn5iez_HHglxO_c1TUMnNnLaDi5U7KT4P9VWaMjRrdvdx0d
 3SAlQzyyiR4s2YOSxwuNY2BPAAEcoZtT1VxTMR7UghyZT4GHfqO9F.JXAq7t9cUGVXjvgDTRJH88
 uja8sHghuBqtgYLug_qTN2CLZR2UYlg8y0XPH0YOpnoKhCrszjYjEj9dWBRqWZ3BIw17dnN2Z9Fd
 3BLtPcJrZ0qpuYoP0hSB.id7mdPW8L2Sj2jZfXhqLGtLr91_eVqv8rmXRjMipLjrQ3QFPm.laEDa
 BZwQ1qWR.p63gNXSDHJ72E3EVc9uyQAG2T74bwuoQqy_rB12QbJ84v8qobllcrUTuDkLHoA5OIkO
 WegNNGf3_gkUDOTrjQL32hqONocLM5kBt3bnEyHcIRwQvjKAygmi_yMvLGRYLEoCywXspKNJQ7_L
 _6HDaIj1Unp3QYlgzRHUIGMOPc_rzZwTXJhwkMg8QvXN5SiUjMNl2kLhNrEnU5MUdLdj983pKmyj
 NQH.niFrtfPTlv.njK24HBmmKQwzQ8EM.TfH8PkNkFInehx2ZZve0j2MtoirbRfC44rdp62X3rRr
 MfTnaDUSXmNx8P338Ve7ycIuesHw.1j2XEvXDilDkXBVkyBQgTVhbkr97g9JrFoJZ3RGWyMk39c3
 LUEMVeLgfiuKWn.sFJMQ2xSKWwty124hGPIU6B8XpfZgbYSmFmfYXN0oU0RO510sVoeQT2ZoU.S6
 620XS1i6PwHUvAmrJWBLilvIXbFcDDYEzLorqnYpHGU8Y_06StAkmbjzJrw4iESQdtFuuLkufEfw
 FS3_OfxID1JfkQyReAqc-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Tue, 19 Oct 2021 19:53:23 +0000
Received: by kubenode540.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 3e58ff3403911a0410e3ec72c97ff0ad;
          Tue, 19 Oct 2021 19:53:20 +0000 (UTC)
Message-ID: <8918e7c6-f70f-9a9a-7acf-5b06bcf53c4a@schaufler-ca.com>
Date:   Tue, 19 Oct 2021 12:53:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] Fixing returning a userspace address for return value
Content-Language: en-US
To:     James Morris <jmorris@namei.org>,
        "T. Williams" <tdwilliamsiv@gmail.com>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <CADN=F_=tijrY7Lwv2coPcXS04uzEQsUL70=v3wHceGe9p6W7pw@mail.gmail.com>
 <7df6e94f-a4c7-d181-7f9a-165e95b493@namei.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <7df6e94f-a4c7-d181-7f9a-165e95b493@namei.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.19116 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 10/19/2021 11:41 AM, James Morris wrote:
> On Tue, 19 Oct 2021, T. Williams wrote:
>
>> Fixing user memory dereference bug.
>>
>> Signed-off-by: Thelford Williams <tdwilliamsiv@gmail.com>
> Casey, can you check the logic on this?
>
>> ---
>>   security/security.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/security/security.c b/security/security.c
>> index 9ffa9e9c5c55..7c41b5d732ab 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -1737,6 +1737,8 @@ int security_kernel_read_file(struct file *file, enum
>> kernel_read_file_id id,
>>          int ret;
>>
>>          ret = call_int_hook(kernel_read_file, 0, file, id, contents);
>> +       if (ret > 0)
>> +               return -EINVAL;

Does the failing configuration include a BPF program that might be
invoked for this hook? SELinux is the only traditional security module
that provides a hook, and it never returns a positive value. I don't
see a case where the proposed check makes any sense. If the problem is
in a BPF program it should be fixed there.

>>          if (ret)
>>                  return ret;
>>          return ima_read_file(file, id, contents);
>> -- 
>> 2.25.1
>>
>> This commit is to fix a userspace address dereference found by
>> syzkaller.
>> The crash is triggered by passing a file descriptor to an incorrectly
>> formed kernel module to finit_module.
>>
>> Kernel/module.c:4175 : Within the finit_module, info.len is set to the
>> return value from kernel_read_file_from_fd. This value is then
>> dereferenced by memcmp within module_sig_check from inside load_module.
>> The value is 0xb000000 so the kernel dereferences user memory and kernel
>> panics.
>>
>> To prevent this adding a check from within security_kernel_read_file to
>> make sure call_int_hook doesn't return an address which in the syzkaller
>> program is what causes the return value to be 0xb000000. Then the return
>> value of security_kernel_read_file is returned to kernel_read_file(also
>> in security/security.c) which returns the value to
>> kernel_read_file_from_fd (fs/kernel_read_file.c) and this returns the
>> value into err then being set to info.len causing the dereference when
>> info is passed into load_module.
>>
