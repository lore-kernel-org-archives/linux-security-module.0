Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023095.outbound.protection.outlook.com [52.101.72.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B12733A9E8;
	Sun, 20 Sep 2026 13:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789910225; cv=fail; b=AMAdKVX4WjU5ecPvzVOnZbAAVkkMSKPCdNKj9mTvT8BJIv8+koN4/pADw2dYPJQFcOACIMQI8HZv+cxJbHcco9WNo/51r3NCPqREtXzEEE6QiN/yF9AqLC+kZNEZtn67NBh7FZs1TQBczkue705I3p+TlMJwyAgf6ozfd3b52HA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789910225; c=relaxed/simple;
	bh=3fl4yZuI3FXsLKMjELIdrUn6cVGZYq54l8GtwquiqpE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 Content-Type:MIME-Version; b=K64voICGsQb8kOGX7aVBSW6iaFToFkHYBgeDWIqnExxYze2QBLnWe2Qh3yWkk1448kwIbKR1jB46w0l/IMUv1NNh2okbE83MoD9Q8VUd6rQHPpu3nVf6F4WIiEv2X3cZVFXfUEm4mwBWVtdZzklVAdY1QMOygS+gpwiG0k7IUis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=polito.it; spf=pass smtp.mailfrom=polito.it; dkim=pass (1024-bit key) header.d=polito.it header.i=@polito.it header.b=MiF8xtIU; arc=fail smtp.client-ip=52.101.72.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=polito.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=polito.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=polito.it header.i=@polito.it header.b="MiF8xtIU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hpXsIw+zK1Dkmg0+5L8FXsWJRALJnRkWPrQ83S2KusdWtKuj1g8PP4Q3INqOQthxBZtgWg7cAEWLGTSnm5Nr/6LIcETteeHuT1M6n7hoh+Am9UAx90URi2hYM1jIJY+nRPwBOCE9zxEDUWnQkLgLfVpUIVmd8Q830yx3Hgf47QSYrTcO5lR2t8o2XZMJYJTbfA4Btbrdnq74B2MmqcTgrHLewQe4cqRbRmlV32tpW71eB/1p/JoEOMEubcqeKn0WJJ8I1CdQ5F2EMsXBvW/72TXwtv9YXuRxPUsSvI3AWoddxe83DDCuMAyPs/Gu5LpfXdd3D6HQq2c6KPrHifatDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3fl4yZuI3FXsLKMjELIdrUn6cVGZYq54l8GtwquiqpE=;
 b=AmU11FUbRKk66fFNbDjx+YVZtkgwqYTTWycQkf73CBjtEe552z+9oUebXE24DJbCkWJsBeY/bRKQdyqmeG3ptrFpQHoUWr3SlilxPzk8pGIgcG+zoYG+X8hBJiAgRWwA9pDvVNGpCucRXBF/rHPi0TIoZcDAK+JBhZzXK1bykqPqtTPJa18vOHdZ+s2JpbMfEKkCrsBs2EuOqvbZbjw+PUOKmCBdhOFDiRC74jDuORB6dR0RIwYZYXhLpri8PP3HRRH1QB6TqSS7LFI2Z8pCYdNQ7vshb3BYILWMB7c55EBGl9c7bUOI3h4yn1m+4gwb4sebmyYDWBGgHahUOvZoIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=polito.it; dmarc=pass action=none header.from=polito.it;
 dkim=pass header.d=polito.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=polito.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3fl4yZuI3FXsLKMjELIdrUn6cVGZYq54l8GtwquiqpE=;
 b=MiF8xtIUm3Roqvlx/z0dqRKgnfu271hIRN8XwlGWfnTrgJbyjqo1wr4G6z1x8ZDx/sQ4EyDunS0Gdozr2VlHsRSCVPWLKEJB4WrhfXUqbmofA2PQrLmW74DNPbmn6bQ4VEH4p1hSVWhGjHM88FAmHo5QbX3oIMqxlXp/QfsUZG4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=polito.it;
Received: from AS8PR05MB7880.eurprd05.prod.outlook.com (2603:10a6:20b:253::20)
 by AMBPR05MB13003.eurprd05.prod.outlook.com (2603:10a6:20b:733::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Sun, 20 Sep
 2026 13:16:54 +0000
Received: from AS8PR05MB7880.eurprd05.prod.outlook.com
 ([fe80::b739:4a27:cccc:cd64]) by AS8PR05MB7880.eurprd05.prod.outlook.com
 ([fe80::b739:4a27:cccc:cd64%4]) with mapi id 15.21.0428.015; Sun, 20 Sep 2026
 13:16:54 +0000
Date: Sun, 20 Sep 2026 15:16:52 +0200
From: Enrico Bravi <enrico.bravi@polito.it>
To: Frederick Lawler <fred@cloudflare.com>
CC: "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
 "roberto.sassu@huawei.com" <roberto.sassu@huawei.com>,
 "eric.snowberg@oracle.com" <eric.snowberg@oracle.com>,
 "paul@paul-moore.com" <paul@paul-moore.com>,
 "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
 "serge@hallyn.com" <serge@hallyn.com>,
 "jmorris@namei.org" <jmorris@namei.org>,
 "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>,
 "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kernel-team@cloudflare.com" <kernel-team@cloudflare.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_1/2=5D_integrity=3A_Report_erro?=
 =?US-ASCII?Q?r_code_in_integrity=5Faudit=5Fmsg=28=29_call_sites?=
User-Agent: Thunderbird for Android
In-Reply-To: <zu2rdshqwc6t72q22nayydud222ecic4ca5inzvte5lqtbnkfu@mcq7ta422era>
References: <20260916-report-hash-error-v3-0-73e5d95e9efe@cloudflare.com> <20260916-report-hash-error-v3-1-73e5d95e9efe@cloudflare.com> <132d83cb5dcfb6fa7024480626a829b4e03309f9.camel@polito.it> <zu2rdshqwc6t72q22nayydud222ecic4ca5inzvte5lqtbnkfu@mcq7ta422era>
Message-ID: <1C982323-4153-4A2D-946B-832DC3A5446F@polito.it>
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MI1PEPF000008C9.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::438) To AS8PR05MB7880.eurprd05.prod.outlook.com
 (2603:10a6:20b:253::20)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR05MB7880:EE_|AMBPR05MB13003:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ed684e7-716c-49bc-c4d0-08df171970a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|786006|376014|23010399003|366016|1800799024|22082099003|18002099003|56012099006|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	24+2ot01VtOCyvOPXsdp+a3tEXDHH69qDt1JIeu1Eyw7tuqx7BFqmK38UC7HU1drlmLt4I7j+l6egna3WBspFHAem/GnQC/QVpaRipxE8tOJC33QBo2jO7dneXqZP3BjcYCitQFnilfgdjiqh6BO0Nr9CVJvvQBCkd3SeXvnMFyo/I5oIoZX5foJuWwPfu6QrFKXRzSPAfE8ZRiIj14Vyg0i+/vOJ2kvGmnM/Jh7lMZJCfpWc96eqU0YIXJwh3CSnC9prghS2MaNwPAbODjrQuIyGIrT0K8jPeA4mK6B94ga/Uxrp7jZbuPadoWMVaDzSrj3RD2ryI/H+gPiVeWKs/dXl69/X6FgWCT3aVA/Ynm2RUsD0xiUKFVPelVeUa5qtf3VwQVuuC1Huhrcf9fXCk2N2DmRmg23GwOjQEDykgP2yyEgByG/wKXyRb+xwJBJJ73WR0ocLXw8isxrtfulDslCx3Fu0PN8dV1Eqjp55ExOTgQWUjA6iZMtSmhZY1O3ZHpEnJunBvbqhil179mpBqcoVMlELJL1z2Jl4Qn2dLwdlm2RzrWpT33LtxwIVGh11bLsylhmyVf+pHyXnKaiAxLzDE1QpzT3WvivrfFFG7VC14faiq8u3Yd2YIFbFwT6JCDsOnqwYw/PibyXOHOC/IYfv+aBfo7QsWBhe055074=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR05MB7880.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(786006)(376014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUhPaHNKRTBCNkhtRUF3NFNiYXlLOUFDaCtQamdZdUt5Rko5RjJaSmJ1NFhU?=
 =?utf-8?B?U2Mxcnd0Q05PcEp2NXptbitJOW1yeVY4VEd5bnEwZkY5REFhQ2NUaDJSNzhQ?=
 =?utf-8?B?clQzUFh5bkZEOUc2dXp2V2xXOW9DdWVUZDZ0MlpPNTlIMm1BUnB1U2NtckJ5?=
 =?utf-8?B?MzNnVzdYZjNvS2tqbUF0dVNzOHhZTEgzRnREenVNVHVqQ3Z6dUhXUEtWK0Z6?=
 =?utf-8?B?N0pFbThEb3h0WXd6RUVyR3Irc09CQjRPYU1Ob29MTjN5OEsvVElYVWNIdzdi?=
 =?utf-8?B?RW40dGJrcWR0Ukh2VDJ6WWN4Qko5UkVCMEE4Q0lMcjRFSHB1K3JDZUV2bXVU?=
 =?utf-8?B?eFJ3Yy9GZGlvMk5mVnN5d1dQZHU3U09pNmNmNmdJblVRVldEOGxqWU1BMVZC?=
 =?utf-8?B?ai9FOHZOMnQweTVSVHlLcXpiRkVqMEh6aFhpVlJDdHAzQldBeWJ4VTZ3b3BB?=
 =?utf-8?B?MCsydDdoMmJmZGlxYmVLS1YybWRRQm1nYzl6UlpoYm9qRXN0UERaYUdqWjFy?=
 =?utf-8?B?UmN6UVZweWp3Wmk3VTRXMU5ucEdIM0haSmlyY3dvdXRPK1VLT0xmMFBwMXcz?=
 =?utf-8?B?MzEwNGxscFBSRnYyMUIzR0FoWDVFRUtVKzFmMkF0ZTFvbzZvV2RTL2xwNGRC?=
 =?utf-8?B?aVhDYjBJM1JTdnJsN2lRVlpyV3NSWFZhSlpMdnA2MDRDMThhMEFYckpnWjd6?=
 =?utf-8?B?MXk3aUtqMUN2VDFFSTk5akJ3djI5aW96YmQrc25EOFVzMEQrYi82dklNL1da?=
 =?utf-8?B?c1ZBVnJUaktZV1lWZkFMenJ2L0ZrZTNpVWw4ZFAxL3hlWkxDVUxFS2lHa0x3?=
 =?utf-8?B?NDlIcmdhK3ZiVm1pUFNlT0JRVnVjeldSYzhQWndFT2J2TWlwaGZHR2Vzdkc0?=
 =?utf-8?B?cDVOZUN6YjRMdGhGVUV6WVJScDYybUxFeDl1M2l1MkVybUtXNEY1QjIxdWNN?=
 =?utf-8?B?OTlTVWk2MjB2aXdQUGp6YnhtUUVNMlN6YkFqd0NsaVRFVzFEY3pkc2hHa0oy?=
 =?utf-8?B?TTJJQVdGYUNmeHBGbUk0dFJiZ2F1TWl3V3V5bTEyRGJpSzNOckVhYUdTMUNm?=
 =?utf-8?B?bWlobGFhZGNSeW5qNFFxWll5eVprRktIM0NrK2oyeGphN0tKOUZuTm9lU2NW?=
 =?utf-8?B?bXpIOHJRbndxeWhDbkJoelhjNHNLalI3WDRieks1eDFRSUlPZXBGRlBVSzYz?=
 =?utf-8?B?c2ZiQldpK1A1NTYvN0NJNWRuSCtPbUdqSGJqYVY5V0lmbDBnWi9sdklzeTk0?=
 =?utf-8?B?ZFBBMDkxYXlRZE1tc0VkSzZEY215Z1pGWjdTMWVlR200SFUweW4vNTA2Yy9O?=
 =?utf-8?B?UC91RjNZQjQwZjBSb20yRTZ6N1hza01JTmovdVdxc1NLSU5aSUtDSDdxYXVO?=
 =?utf-8?B?ZjdiaFZiV2xGZDVPR25zV2pzdkc3NFljT1dDaGFuVUkzdFZpdjJGaitJWjNC?=
 =?utf-8?B?WGtZUE5vajVsdVJHTCt2TkdNY0FZTEZ6ejAvZ1BBdzFTWkVOVTFmcytQUy9k?=
 =?utf-8?B?ZnA4Sms1dmdpTzA0TENVazRxbS8zbkk1OWpUcGFjSGhIRk1NM3BaZXUvQ0Ni?=
 =?utf-8?B?R1hVWU14emFmbWNZTWs1UlNVYkdYblJwbWMwL0NhaGdPOVI5MkUrOVpGYlZL?=
 =?utf-8?B?T0ZQcVlSYnVkVTZOZnI5VXgvOU9aUlBBOEpMaU5wamF1VEFkVkxadEF3TkVT?=
 =?utf-8?B?VnYybWU1SnBoS3hmWGlGSk5MMmgxVVpQbFdGR2dKYTdnRnV2SUtCSWk5L2Jo?=
 =?utf-8?B?eERLejBFUHY4ZElqU01RSTNLejh6K2FqazBKS1BLNkxreTQrNVN6TXZ1R2dJ?=
 =?utf-8?B?Yk1IZFBPNUFLSjd0QVpXTFJyWTI3MStxVWVNNVM4YTFmS1N2OUovZWJqWmRL?=
 =?utf-8?B?UlRsWndVZGxPejRaSGxJSzgvbnBNbmNUbndHR2hQaTNnUnlQcjhXdDVkZ20z?=
 =?utf-8?B?YkF5cDBQUU1OSDR2VmZMdTVUdk5mWTJBQ0MwdGovYllXM21jV0RkRmplM3ZF?=
 =?utf-8?B?MlRSNkcvOWI3M3BUK3dUWVNTQ2lxSmxpajRnQ2ZKYnFBY1liOWpYZzV1ekl5?=
 =?utf-8?B?dXB0SW1TMFVmL1NZV1FCT3J1NFRNNGxuQlBTaVU4a1pPdmwwc3JxOERyQU1B?=
 =?utf-8?B?ZlFDMGhZdGpZZWdKK3EzWk9rV3VQYUZiKzBUYzNNd1FLSHJFVzg4SG9ESFVl?=
 =?utf-8?B?QVA4ZkpPMjQzOHpuaElzRi96ZTZsRG5vSVY3czZXTC9rRjh2bGJkTDF2SjhR?=
 =?utf-8?B?dkh4bWswOG1iakpyQStUbUpSVGJ4WTZKLzhwNXFBakZGMXdFT09VVlV3NzRm?=
 =?utf-8?B?dmRMK1FUUW9oTWZjS0pjQUpnbkdsRzJhcWcxOFRKcVJpSnpzRmZWZz09?=
X-OriginatorOrg: polito.it
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ed684e7-716c-49bc-c4d0-08df171970a6
X-MS-Exchange-CrossTenant-AuthSource: AS8PR05MB7880.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2026 13:16:54.2701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2a05ac92-2049-4a26-9b34-897763efc8e2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E37xiH5tVPc3vunwC7DMAKmuwbWmHXbc9H90pMMH7oKH19yyNo2oqr96SfU2eD5gdV4cTfOIuODfCrNLuJM7NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR05MB13003

On Fri, 2026-09-18 at 16:11 -0500, Frederick Lawler wrote:
> Hi Enrico,
>=20
> On Thu, Sep 17, 2026 at 10:58:22PM +0000, Enrico=C2=A0 Bravi wrote:
> > Hi Frederick,
> >=20
> > On Wed, 2026-09-16 at 16:36 -0500, Frederick Lawler wrote:
> > > integrity_audit_msg() hides error codes by wrapping
> > > integrity_audit_message() which obfuscates the underlying reason for =
the
> > > failure.
> > >=20
> > > Update integrity_audit_msg() call sites
> >=20
> > here it could be mentioned that also integrity_audit_msg() itself is
> > updated.
>=20
> Good point. I can see that I may have not been clear about that.
> =C2=A0=C2=A0
> > > diff --git a/security/integrity/ima/ima_fs.c
> > > b/security/integrity/ima/ima_fs.c
> > > index
> > > 2a0bca5543161912abe2a0236c9fcae7055e62bc..6d2ef44b21f8d40b4981a6a441c=
f7c3d
> > > 69f9
> > > 4dee 100644
> > > --- a/security/integrity/ima/ima_fs.c
> > > +++ b/security/integrity/ima/ima_fs.c
> > > @@ -595,7 +595,7 @@ static ssize_t ima_write_policy(struct file *file=
,
> > > const
> > > char __user *buf,
> > > =C2=A0 pr_err("signed policy file (specified as an absolute pathname)
> > > required\n");
> > > =C2=A0 integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL, NULL,
> > > =C2=A0 =C2=A0=C2=A0=C2=A0 "policy_update", "signed policy required",
> > > - =C2=A0=C2=A0=C2=A0 1, 0);
> > > + =C2=A0=C2=A0=C2=A0 1, 0, -EINVAL);
> >=20
> > Here it could be put -EACCES as errno, being the value returned for thi=
s
> > case.
>=20
> Sashiko said the same. I kept going back and forth on this one because
> of what the message actually says. EACCES is the result, but the string
> itself + pr_error() implies that it's an input error. Similar to
> ima_release_policy() below, I should probably keep this zero, and
> follow up.

Hi Frederick,

AFAIU these messages justify why the policy loading has been denied. The po=
int
seems to be that the input policy, even if it is valid, cannot be verified =
in
that form, because the signature is missing. The user can write the policy
directly on the securityfs file, but is not allowed to when a signed policy
is required. For this reason,
-EACCES could be better, because it is referring to an action permitted by =
the
system, but not allowed by the current policy.

Regards,

Enrico

> > > =C2=A0 result =3D -EACCES;
> > > =C2=A0 } else {
> > > =C2=A0 ima_measure_raw_policy(data, datalen);
> > > @@ -745,7 +745,7 @@ static int ima_release_policy(struct inode *inode=
,
> > > struct
> > > file *file)
> > > =C2=A0
> > > =C2=A0 pr_info("policy update %s\n", cause);
> > > =C2=A0 integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL, NULL,
> > > - =C2=A0=C2=A0=C2=A0 "policy_update", cause, !valid_policy, 0);
> > > + =C2=A0=C2=A0=C2=A0 "policy_update", cause, !valid_policy, 0, 0);
> >=20
> > Here maybe it could be put a conditional errno, based on the validity o=
f the
> > policy, instead of hardcoding a zero.
>=20
> I can see that making sense to throw a -EINVAL on it. The function
> is designed to always succeed, but it might be worth pulling out the
> error code from ima_check_policy() for this case.
>=20
> Best,
> Fred
