Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9ABC4338F
	for <linux-security-module@archiver.kernel.org>; Fri,  6 Aug 2021 18:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26C57611C3
	for <linux-security-module@archiver.kernel.org>; Fri,  6 Aug 2021 18:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238572AbhHFSdq (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 6 Aug 2021 14:33:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37480 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234112AbhHFSdp (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 6 Aug 2021 14:33:45 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 176I4MVc102015;
        Fri, 6 Aug 2021 14:33:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type; s=pp1; bh=AoOfWhGoNl1nzmwxqrEI2DuYnecQ+A/jPVAw3H6AWSA=;
 b=W2XloxkxUbuemrwR4eJ9t3fM9fSaP9m5av0Whgj0NGF3jfbdq68gehZQE8q95M+8Bp7j
 BlNnzmT1V1vqzcrKe5Z7y6bc3hAdM2L/woanK9yMJgPEzUGQJxAmEzAABo7fc9Z4XQ1s
 rjUGcu8eCj3dEHFWhgexK5RkDhhdVej2r2xkYaoQtiDRkIny7N7aM2qgafuGBRrj26h3
 I2a6/PJno72v8BI1m9quG1phknv21lhoWd3PqYs5zOsdMZNNQ75DOj15oC/jaSTrQI6y
 Ou4eDcYgXfdNNo/6VHK/T+Wcdgv2/Wr34MSIQEtUt0vXt5foM2/Vi9Lo+opI7OITy4FA PQ== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a89fnyf5w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Aug 2021 14:33:27 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 176IWJT2032240;
        Fri, 6 Aug 2021 18:33:26 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma05wdc.us.ibm.com with ESMTP id 3a8mqa1jqm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Aug 2021 18:33:26 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 176IXPN934210120
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Aug 2021 18:33:25 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 86B827805C;
        Fri,  6 Aug 2021 18:33:25 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC5D57805F;
        Fri,  6 Aug 2021 18:33:24 +0000 (GMT)
Received: from [9.211.130.149] (unknown [9.211.130.149])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri,  6 Aug 2021 18:33:24 +0000 (GMT)
Subject: Re: [PATCH] LSM: add NULL check for kcalloc()
Cc:     linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-team@lge.com
References: <20210712234434.GA29205@raspberrypi>
 <e0a2655b-3bc6-fd45-bd84-8df2dc6bc5f@namei.org>
 <CADLLry6RmSDuB4nmVKDEiqxXmEU0xrhMn2wieuuVTypMWqc4cQ@mail.gmail.com>
From:   Ken Goldman <kgold@linux.ibm.com>
Message-ID: <b58ae08c-c3b9-12a9-f862-bebfed8a01f2@linux.ibm.com>
Date:   Fri, 6 Aug 2021 14:33:25 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CADLLry6RmSDuB4nmVKDEiqxXmEU0xrhMn2wieuuVTypMWqc4cQ@mail.gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms040506020904000909030205"
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: R47yuhnA32oit6veb7sBrvfxeUI-HiCF
X-Proofpoint-GUID: R47yuhnA32oit6veb7sBrvfxeUI-HiCF
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-06_06:2021-08-06,2021-08-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 adultscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108060123
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This is a cryptographically signed message in MIME format.

--------------ms040506020904000909030205
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 7/14/2021 5:44 PM, Austin Kim wrote:
> 2021=EB=85=84 7=EC=9B=94 15=EC=9D=BC (=EB=AA=A9) =EC=98=A4=EC=A0=84 4:1=
2, James Morris <jmorris@namei.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:=

>>
>> On Tue, 13 Jul 2021, Austin Kim wrote:
>>
>>> From: Austin Kim <austin.kim@lge.com>
>>>
>>> kcalloc() may return NULL when memory allocation fails.
>>> So it is necessary to add NULL check after the call to kcalloc() is m=
ade.
>>>
>>> Signed-off-by: Austin Kim <austin.kim@lge.com>
>>> ---
>>>   security/security.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/security/security.c b/security/security.c
>>> index 09533cbb7221..f885c9e9bc35 100644
>>> --- a/security/security.c
>>> +++ b/security/security.c
>>> @@ -321,6 +321,8 @@ static void __init ordered_lsm_init(void)
>>>
>>>        ordered_lsms =3D kcalloc(LSM_COUNT + 1, sizeof(*ordered_lsms),=

>>>                                GFP_KERNEL);
>>> +     if (ordered_lsms)
>>> +             return;
>>
>> Your logic is reversed here.
>=20
> I feel very sorry for my terrible mistake.
> 'if (ordered_lsms)' should have been 'if (!ordered_lsms)'.
>=20

I know it's a bit more typing, but

	if (ordered_lsms =3D=3D NULL)

compiles down to the same binary and avoids there errors that
try to treat a pointer as a boolean.



--------------ms040506020904000909030205
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
JTNkQWN0YWxpcyUyMFMucC5BLiUyZjAzMzU4NTIwOTY3LGMlM2RJVD9jZXJ0aWZpY2F0ZVJl
dm9jYXRpb25MaXN0O2JpbmFyeTA9oDugOYY3aHR0cDovL2NybDA1LmFjdGFsaXMuaXQvUmVw
b3NpdG9yeS9BVVRILVJPT1QvZ2V0TGFzdENSTDAdBgNVHQ4EFgQUvpepqoS/gL8QU30JMvnh
LjIbz3cwDgYDVR0PAQH/BAQDAgEGMA0GCSqGSIb3DQEBCwUAA4ICAQAmm+cbWQ10sxID6edV
94SAhc1CwzthHFfHpuYS30gisWUfWpgp43Dg1XzG2in3VGV7XrzCCGZh4JM/XQWp+4oxmyV4
2Qjz9vc8GRksgo6X2nYObPYZzQjda9wxsCB38i4G3H33w8lf9sFvl0xm4ZXZ2s2bF/PdqvrK
0ZgvF51+MoIPnli/wJBw3p72xbk5Sb1MneSO3tZ293WFzDmz7tuGU0PfytYUkG7O6annGqbU
1I6CA6QVKUqeFLPodSODAFqJ3pimKD0vX9MuuSa0QinH7CkiPtZMD0mpwwzIsnSs3qOOl60t
IZQOTc0I6lCe1LLhrz7Q75J6nNL9N5zVwZ1I3o2Lb8Dt7BA13VFuZvZIzapUGV83R7pmSVaj
1Bik1nJ/R393e6mwppsT140KDVLh4Oenywmp2VpBDuEj9RgICAO0sibv8n379LbO7ARa0kw9
y9pggFzN2PAX25b7w0n9m78kpv3z3vW65rs6wl7E8VEHNfv8+cnb81dxN3C51KElz+l31zch
FTurD5HFEpyEhzO/fMS5AkweRJIzwozxNs7OL/S/SVTpJLJL1ukZ1lnHHX0d3xCzRy/5HqfK
3uiG22LPB5+RjNDobPAjAz2BKMfkF/+v0pzn8mqqkopQaJzEAbLbMpgQYHRCjvrUxxwjJyUF
b2Z+40UNtMF4MTK7zTGCA/MwggPvAgEBMIGWMIGBMQswCQYDVQQGEwJJVDEQMA4GA1UECAwH
QmVyZ2FtbzEZMBcGA1UEBwwQUG9udGUgU2FuIFBpZXRybzEXMBUGA1UECgwOQWN0YWxpcyBT
LnAuQS4xLDAqBgNVBAMMI0FjdGFsaXMgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIENBIEczAhBt
lC9msSpKrr0rmsrvlS70MA0GCWCGSAFlAwQCAQUAoIICLTAYBgkqhkiG9w0BCQMxCwYJKoZI
hvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMTA4MDYxODMzMjVaMC8GCSqGSIb3DQEJBDEiBCAY
LA0B/qvmROLyS3zGeYt0/GWuuNUFoGCN2HRpKFw6OTBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCG
SAFlAwQBKjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqG
SIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGnBgkrBgEEAYI3EAQxgZkwgZYw
gYExCzAJBgNVBAYTAklUMRAwDgYDVQQIDAdCZXJnYW1vMRkwFwYDVQQHDBBQb250ZSBTYW4g
UGlldHJvMRcwFQYDVQQKDA5BY3RhbGlzIFMucC5BLjEsMCoGA1UEAwwjQWN0YWxpcyBDbGll
bnQgQXV0aGVudGljYXRpb24gQ0EgRzMCEG2UL2axKkquvSuayu+VLvQwgakGCyqGSIb3DQEJ
EAILMYGZoIGWMIGBMQswCQYDVQQGEwJJVDEQMA4GA1UECAwHQmVyZ2FtbzEZMBcGA1UEBwwQ
UG9udGUgU2FuIFBpZXRybzEXMBUGA1UECgwOQWN0YWxpcyBTLnAuQS4xLDAqBgNVBAMMI0Fj
dGFsaXMgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIENBIEczAhBtlC9msSpKrr0rmsrvlS70MA0G
CSqGSIb3DQEBAQUABIIBAD641EoyAZ/wKfP8s5JSGGU9WC+jBVGmKU8Hx1xKbLvTtDlqaOwC
i9/DROOpYckB/OTRFWiKHEUmhRMYoveI622BAUEgJRlrVWnvKmbkhnG+uKt9HZsPBDB/AWWo
6oyWpFQHbI1GjMASnNlg45Io9V7AGBDEUDh3IHUYgntMuKKNYnPWHVKCapW9vUabamrtmR/l
3j6b1ACzJjzrU0fJ3cwyuhIuHqea+4PCw5igOzJKdzoSXI5NetP8uvqUIFRwvf1mNeHZ9lVR
CVWXLlKEUw07tXuyav0m7mOa1/Vk/8fkHBfbS+e/sEdko8Cstfr9s0MugG43SwwAZ3nkS7NU
fv0AAAAAAAA=
--------------ms040506020904000909030205--

