Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023127.outbound.protection.outlook.com [52.101.72.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9389A199947;
	Fri, 25 Sep 2026 20:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790368553; cv=fail; b=hwPcwY8MVHEhZSQeVHt9uXJmi6mXb88Wn7olPZr3pZCYzRXftxzGyRE3g1Lqmcm7W+OB3bxNb2IuY2+AVM15skaztLLyswCHxIKxX5j0WJUep9zwWn/kf2ZlAbLhCyivqE3SXGENiamEvcTRv+k0MZw8rvsByNfZT8vw2TpAqOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790368553; c=relaxed/simple;
	bh=PL3fqLZ4rNvvGX67u+Vuf664pJwkSEayodVpMvU4wkM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 Content-Type:MIME-Version; b=tGfxRD2VFCZLrB4oWkuzjcu2mXnTo49cr5Leb6kvsUoF4QYoYbJPrtnRCMi+wDgmGQHyQC63e4eHOJNQchU48Ao9AKDJJ8ilqUYWHIClUBSj4MifSTc4upHpoiuE9Rqx0+n6uoX8Z3ijjTMOtc9KV0Ij92y4BJ2FfHUkcUglydM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=polito.it; spf=pass smtp.mailfrom=polito.it; dkim=pass (1024-bit key) header.d=polito.it header.i=@polito.it header.b=RvM95djN; arc=fail smtp.client-ip=52.101.72.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=polito.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=polito.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=polito.it header.i=@polito.it header.b="RvM95djN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UiX5viqZAjdPiakAVl1DAtLdEJ7njGnWM+bEtHbPINjxtnUQ9YolFJur01CzvCVdXwFnOg/Mwg5yxtNvLle12GusLPIg+EAw1OpChoSdCWjJiYEMWyaVkuC0ZPB3foLHgaolGZ90qcYBU3m6rhh8g1w9eQBVEK4ZtWebe/cl8uV4+pD9NCgVrvaBqKeCByRW7PLrbN5ZTsmVebYigjw0qLX6sEyINyOtHh2b0JlckabJsCDRP9j42pfI1REqYO+G+cWCbL73ObcVphEiTfQPXBBgC6/trQQPAMLQverzmimedEWYCxyRsoywziLdDWB81yvuNkOF0vay19CXc+Vfzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+YwgIrg5+/EyPKyqL9qFJIb3iHc8lOsY9xCuFYzPCwQ=;
 b=Q0dJlA7WD/N4TdVGwJjCStv8yeeqL7l1qzenTh/M4XYc1eQZsBFPtwkhXfBSFGKg1clFt7XaWEqMLsJGcatFv11JZICPwcRAU732luqxdpMn2PFAdhDClZzp7eDPtfb38bf1kvqfcXeNExcZ9GHcJmS3h9ZrWSgOPtoR480ea+KpozUlTrtr86ZdXqF6I0ZHu4zAgXbPkdOcZzS8q1NHqiQ6Ij673SNs11n6cc/4WnjBMaZxJWa58MBYJi5KKlqKtwyoDW1bmKNTOJpO/xnTMSWoSJkj9mMhppcHU14RzrZS1kJvvQnnaopx6DrtKPwjFYiGSowq0fZ3xuAz9bdXoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=polito.it; dmarc=pass action=none header.from=polito.it;
 dkim=pass header.d=polito.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=polito.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+YwgIrg5+/EyPKyqL9qFJIb3iHc8lOsY9xCuFYzPCwQ=;
 b=RvM95djN4eSBid2NCDB3JnUko5k39s+2aJWjs2fj+eaYMNGQr2gLMkk2htVdUrZfMLgaJdEgf27pPyHTpaee5vfxLqAKtN0u2c7z3MCi79+4esfY3/UHsQa0CYtzzuEpZpJ9xEQw+i+1MDSFSVcMnz+7DhkR/FGKbyCHwUNtlQ0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=polito.it;
Received: from AS8PR05MB7880.eurprd05.prod.outlook.com (2603:10a6:20b:253::20)
 by AMBPR05MB12841.eurprd05.prod.outlook.com (2603:10a6:20b:763::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Fri, 25 Sep
 2026 20:35:44 +0000
Received: from AS8PR05MB7880.eurprd05.prod.outlook.com
 ([fe80::b739:4a27:cccc:cd64]) by AS8PR05MB7880.eurprd05.prod.outlook.com
 ([fe80::b739:4a27:cccc:cd64%4]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 20:35:44 +0000
Date: Fri, 25 Sep 2026 22:35:42 +0200
From: Enrico Bravi <enrico.bravi@polito.it>
To: Frederick Lawler <fred@cloudflare.com>, Mimi Zohar <zohar@linux.ibm.com>,
 Roberto Sassu <roberto.sassu@huawei.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>
CC: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_1/2=5D_integrity=3A_Report_erro?=
 =?US-ASCII?Q?r_code_in_integrity=5Faudit=5Fmsg=28=29_call_sites?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260924-report-hash-error-v4-1-196ca6350619@cloudflare.com>
References: <20260924-report-hash-error-v4-0-196ca6350619@cloudflare.com> <20260924-report-hash-error-v4-1-196ca6350619@cloudflare.com>
Message-ID: <F3426284-429D-469B-A72A-7645D03A246A@polito.it>
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MI3PEPF00007534.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::4c6) To AS8PR05MB7880.eurprd05.prod.outlook.com
 (2603:10a6:20b:253::20)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR05MB7880:EE_|AMBPR05MB12841:EE_
X-MS-Office365-Filtering-Correlation-Id: d120a12c-5bec-44c8-5ed4-08df1b44927d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|786006|23010399003|7416014|376014|1800799024|366016|10067099003|11063799006|260925022911599003|260925021911599003|260925021311599003|18002099003|22082099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	hdqs4virAB2tKSnN+WEoxDjsHTC1lMqzKBsW4VdTHXIXWTw0+UQO7skZkc//lcrsr05P1Fhhj6/8vU31GJC0mZKNiQHUHcM+HwMkLOljY95JaQfAx9RJMl/DBf5ykueCw+Rx1Eydj+XgzlnfXDW43HIFSfk8mLKeLpn2JrhVuFjJsULai4nQxYryylIY26TKzl7uaieIpOlWPkhGI61AsltEUu/lNFulWhVDGXUp5dpmsBioT/RUKv4A5/KgabI4rZ7qpQj29qpr3x6ac9qhbZgs0MVdNxp7VcD6OyXDsyUFeH2s76QvCBG5zYY4XSnPTFNbDTh7cyU9p1v2YIG30isMGeeatt4dJL+KA3BVdAw35oohh9Nl7i0ojfmBVddG5wd1EJbpQgixkGXqImGzMw1UmEpGUZImDfNwhPa9NJ0R520mDqGkGYy0zEKolHZGCau3sde+PROEjeXzhEF00rWwrAjY/CHW+DdhFURIKGrW5g7OgCSUKXu1oclPVYeg/dG3OGVmn0iwHWKU6si26hEK55puElUvd5JCGbjVrPsajHnnr0N9aKR4Ny67tv+YcdTshwjUQImXd1BGXdh5XwjYEQpv0Bk71qohgc5+RKTQhFJ6WbZMaozBVbd5T/Jno1dOa6YOCuXEsYFMKGoXul6mPrSQ8QQrJEViPi5hm3w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR05MB7880.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(786006)(23010399003)(7416014)(376014)(1800799024)(366016)(10067099003)(11063799006)(260925022911599003)(260925021911599003)(260925021311599003)(18002099003)(22082099003)(4143699003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWZvUUNISXpIMUFnSVMxRmVVWHFhcXNBc2QyWG9JUFczekhyM2srYjN3a0JU?=
 =?utf-8?B?bXFSOGJudFNweTNjZkthbmdlbDRJd0s4bE1JRUR0VHE0ZGZadFBVR0IvN1dV?=
 =?utf-8?B?Z0NSdVJ0dGpSY3VGajhlZ1g2QSs3b203U3VDOWNJWW5CbFpwbEN3UjIxNVY5?=
 =?utf-8?B?bEVyYWI1aDF1TW45bGdOdW83NVZSaXAzNEJsOXFKdXQxQkp6MHRFOFdVMHdz?=
 =?utf-8?B?c1ArTjJYeU9lVjBnWjA3cmVVUjcycXR5K3B3cGJFNFNtdFJocS94d2hTSHVX?=
 =?utf-8?B?bDBTTExhbWozZmZQNlc1eE5nWHFsQStMZitmd0JJL0NPSEFTVEhMdi9KYS9i?=
 =?utf-8?B?Q2NLbmpYRzRmV0Nna2d1N3BPZWN5VGZmTFFZQUREUEpIYm44NlNFV3BmRENX?=
 =?utf-8?B?dC9ZQlZGRHI4by9VcGwwZS8ybHBTQU1rVHlYVzZWSk1HaVpqNVlhWHVIR0NE?=
 =?utf-8?B?Sk52dVBzY0xMeGxKUDJjeHVXbFlkTVRYVnFNWjQyVGtHK2xWaHprb0NUM3F1?=
 =?utf-8?B?TW9jQi9WazYwTm5uNXFIZndKSXNtSXArbXlha0NTZVB5cktjb3poQ2dlRXdk?=
 =?utf-8?B?VjFFYkJySG8wUVlyeWloTGZUYU9xT20xa0ZZSUdHSWRpVmhraW9JN281bWhw?=
 =?utf-8?B?ZEdoSlJ1aG5rN0hwbENTQkxVZWpVdElsaEY0dHltTlRPdW5rWWM3cDdtOG5P?=
 =?utf-8?B?RTZCMnFDVzYwQ1cwdEJ3RDJ3V0xRV2xsNEFFS3dIcnVLRTl1OVNzNXp6M0dx?=
 =?utf-8?B?M1RJbW05Z1h1d2xKSjh0Vi9acTd1QXhjcHFndytLaElObGR4SENpRFA1WndJ?=
 =?utf-8?B?UzJJTFEwc0x3cDE5YUhyMkFlZEdDei94U3NaVXAyaE5zdHlSTEFSWnNiTXhG?=
 =?utf-8?B?T1FuMnMyUWpsbitJdG45WURiZG81Q0F2TkJhR0djNXU4d0RWcEZ6b2NjOGpX?=
 =?utf-8?B?VEVWaXZ1OGdsUmQrNHd6dENGaE5mU2NCQ0hkMWsxa2E0ZlZlMTVTaFVUaHpH?=
 =?utf-8?B?VkZuRUMwLzBwRGhTeEwyNStENVBIOTZvUWpUTURmQVIxdVM0WnY0c3hQTDVa?=
 =?utf-8?B?bENqekpwMFhFM0VWMzBuc0twbGl4NytvOHphZ3lxZDF3eVBza1VCbmhjbDdr?=
 =?utf-8?B?N2dBUmtZSm1HVnBId1hUUGMrbHVSUVVuN1NmNUZZMDZxN2V6eXdJSzlrN1lo?=
 =?utf-8?B?ZmZoL1BVUk5Za1NscVN1clFqTjFyRHVYdG1uUjFobDdsSHdqM2hwNlQ2S21o?=
 =?utf-8?B?WVlEYmhTK1I4N1pabUpDVnFWMU9raGNVc0lJNVpydjNqMWlNUkU1QlJ5a29H?=
 =?utf-8?B?VXJYeHRraU5qZ0Z2LyszZHAwZTJoQktlVFNWZ0c5SDdEblY5TExFNEdsQ01y?=
 =?utf-8?B?MDdhbjYyNVFYejhDZzU2NU1sU2dOZG40ZC81OXIwSGVUaVgwMWVxTHAzNGdB?=
 =?utf-8?B?M2twUlhBS0xhbFR6NXdOaXBhYkRKWllmcGpmeVBJRElIY1RoMEdSWDRKZlYx?=
 =?utf-8?B?OEFyclhwb0RaWTdvbXFzVGxpVkxrWWFHb3hoS2NZeUZDNGM3ZDNNSHVDNnZP?=
 =?utf-8?B?QUlmQmhxZlMwU1FYZEs2U1g5eXRvWnhzdXpBZW0wSldWUUNoNlRBWFBGUjVs?=
 =?utf-8?B?QjlQeXhwQXNwWERLaTNGMkpYS3UvWWRnOUcxbktHeEJFZytDRlVuek0zVEIv?=
 =?utf-8?B?aTVKVmhoQUw1RldTVFNDamVFcEtWbHRxTjdFZ0tFZnFhNmxtR2ZhaUlkTi9a?=
 =?utf-8?B?TmtRZ3Z3d3pwRXQvdW14WXRuUU1FRmhsczFybHFvN1RJaDBGMjhIT2FhY0Uz?=
 =?utf-8?B?NmJTeWdXTlhBeStRZlM4bFVuVFhIaGJhZmR0UG9VYUkwRDQzU1hkdlBWSjdV?=
 =?utf-8?B?TjNtS1dINVNhclJEbW4yeVZlU2Y0VCtaTHRycVRWWkJxL1psY0FXK1BldFBw?=
 =?utf-8?B?YXRDSTh5SHMxYkpSVzZsejZ2TytWNCsrcWdqd1lMREhWNEJxRVJKZ3dWWjZW?=
 =?utf-8?B?VkhBR2xGbXZXVUpWN1p4VHNzaEZ0UzRIeEExUnk3bXExU1RyYXlRYTJCV2Nv?=
 =?utf-8?B?WDl4RnBpZ0NGbkNEeGtqVDNmSnROUnloRGFxbm81NXU3SW01bkRRSklsTlI0?=
 =?utf-8?B?YkZicmxld0ZabTlVenhiMkZqNlpnTW5TVmRuelNlWEQ4aGRpeWZ6SUEyQ05R?=
 =?utf-8?B?WmlNZHRyWkQ5eFFxRmYrYmhVdmNlbklOZkpsaFVXK0E5TVFueUIrdUpabTBa?=
 =?utf-8?B?b0FZWUZGY05zbEpHY0w5Vld0b1NVSkp0eUVyOUdDdlVRZHo5NVlrelFieHZn?=
 =?utf-8?B?bWc5QzFQWCtSaVEwM1lISU14V2xZRkNtYjVWOVFBTnVlNSs3RlpiZz09?=
X-OriginatorOrg: polito.it
X-MS-Exchange-CrossTenant-Network-Message-Id: d120a12c-5bec-44c8-5ed4-08df1b44927d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR05MB7880.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 20:35:44.2017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2a05ac92-2049-4a26-9b34-897763efc8e2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tASF2iYTCFDtsu1EW8Dzjlj+egZSX5npkP38MecK++X9des1K8Tuk02uhuP+wcfw7hSsiCTP7ec/FQwoq80WOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR05MB12841

Hi Frederick,

On September 24, 2026 10:34:58 PM GMT+02:00, Frederick Lawler <fred@cloudfl=
are.com> wrote:
>integrity_audit_msg() hides error codes by wrapping
>integrity_audit_message() which obfuscates the underlying reason for the
>failure.
>
>Update integrity_audit_msg() to take a errno argument, and pass that
>through to integrity_audit_message(). Then update call sites to
>take caller's respective error codes.
>
>ima_appraise_measurement() stores xattr_len as the return code, but
>can replace it with a error code later. Therefore conditionally use
>a code if rc < 0, otherwise report zero. Lastly, conditionally use
>-EINVAL for ima_release_policy().
>
>Signed-off-by: Frederick Lawler <fred@cloudflare.com>

Reviewed-by: Enrico Bravi <enrico.bravi@polito.it>

Regards,

Enrico

>---
> security/integrity/evm/evm_main.c         |  9 +++++----
> security/integrity/ima/ima_api.c          |  8 ++++----
> security/integrity/ima/ima_appraise.c     |  6 +++---
> security/integrity/ima/ima_fs.c           |  7 ++++---
> security/integrity/ima/ima_init.c         |  2 +-
> security/integrity/ima/ima_main.c         |  7 ++++---
> security/integrity/ima/ima_policy.c       | 11 ++++++-----
> security/integrity/ima/ima_queue.c        |  2 +-
> security/integrity/ima/ima_template_lib.c |  2 +-
> security/integrity/integrity.h            |  5 +++--
> security/integrity/integrity_audit.c      |  5 +++--
> 11 files changed, 35 insertions(+), 29 deletions(-)
>
>diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/ev=
m_main.c
>index b59e3f121b8a89edb14d811351ec393a69de8ff7..5be9349afcd09b47b78d1126ff=
c1fe341264ae6e 100644
>--- a/security/integrity/evm/evm_main.c
>+++ b/security/integrity/evm/evm_main.c
>@@ -563,7 +563,7 @@ static int evm_protect_xattr(struct mnt_idmap *idmap,
> 				    dentry->d_inode, dentry->d_name.name,
> 				    "update_metadata",
> 				    integrity_status_msg[evm_status],
>-				    -EPERM, 0);
>+				    -EPERM, 0, -EPERM);
> 	}
> out:
> 	/* Exception if the HMAC is not going to be calculated. */
>@@ -588,7 +588,7 @@ static int evm_protect_xattr(struct mnt_idmap *idmap,
> 		integrity_audit_msg(AUDIT_INTEGRITY_METADATA, d_backing_inode(dentry),
> 				    dentry->d_name.name, "appraise_metadata",
> 				    integrity_status_msg[evm_status],
>-				    -EPERM, 0);
>+				    -EPERM, 0, -EPERM);
> 	return evm_status =3D=3D INTEGRITY_PASS ? 0 : -EPERM;
> }
>=20
>@@ -729,7 +729,7 @@ static int evm_inode_set_acl(struct mnt_idmap *idmap, =
struct dentry *dentry,
> 		integrity_audit_msg(AUDIT_INTEGRITY_METADATA, d_backing_inode(dentry),
> 				    dentry->d_name.name, "appraise_metadata",
> 				    integrity_status_msg[evm_status],
>-				    -EPERM, 0);
>+				    -EPERM, 0, -EPERM);
> 	return -EPERM;
> }
>=20
>@@ -992,7 +992,8 @@ static int evm_inode_setattr(struct mnt_idmap *idmap, =
struct dentry *dentry,
>=20
> 	integrity_audit_msg(AUDIT_INTEGRITY_METADATA, d_backing_inode(dentry),
> 			    dentry->d_name.name, "appraise_metadata",
>-			    integrity_status_msg[evm_status], -EPERM, 0);
>+			    integrity_status_msg[evm_status], -EPERM, 0,
>+			    -EPERM);
> 	return -EPERM;
> }
>=20
>diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima=
_api.c
>index 122d127e108dcca8ddae6575c908144859783fb6..f765bfe5db68d0847cfe5b47f8=
1b64018083f65a 100644
>--- a/security/integrity/ima/ima_api.c
>+++ b/security/integrity/ima/ima_api.c
>@@ -116,7 +116,7 @@ int ima_store_template(struct ima_template_entry *entr=
y,
> 		if (result < 0) {
> 			integrity_audit_msg(AUDIT_INTEGRITY_PCR, inode,
> 					    template_name, op,
>-					    audit_cause, result, 0);
>+					    audit_cause, result, 0, result);
> 			return result;
> 		}
> 	}
>@@ -159,7 +159,7 @@ void ima_add_violation(struct file *file, const unsign=
ed char *filename,
> 		ima_free_template_entry(entry);
> err_out:
> 	integrity_audit_msg(AUDIT_INTEGRITY_PCR, inode, filename,
>-			    op, cause, result, 0);
>+			    op, cause, result, 0, result);
> }
>=20
> /**
>@@ -330,7 +330,7 @@ int ima_collect_measurement(struct ima_iint_cache *iin=
t, struct file *file,
>=20
> 		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode,
> 				    filename.name.name, "collect_data",
>-				    audit_cause, result, 0);
>+				    audit_cause, result, 0, result);
>=20
> 		release_dentry_name_snapshot(&filename);
> 	}
>@@ -383,7 +383,7 @@ void ima_store_measurement(struct ima_iint_cache *iint=
, struct file *file,
> 	result =3D ima_alloc_init_template(&event_data, &entry, template_desc);
> 	if (result < 0) {
> 		integrity_audit_msg(AUDIT_INTEGRITY_PCR, inode, filename,
>-				    op, audit_cause, result, 0);
>+				    op, audit_cause, result, 0, result);
> 		return;
> 	}
>=20
>diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/im=
a/ima_appraise.c
>index b280488e15fcb0b6f8a8a0caaab93c7d511e4a40..84c4dee2323cf7352cccd8e4c9=
291d0fb6eed8e1 100644
>--- a/security/integrity/ima/ima_appraise.c
>+++ b/security/integrity/ima/ima_appraise.c
>@@ -564,7 +564,7 @@ int ima_appraise_measurement(enum ima_hooks func, stru=
ct ima_iint_cache *iint,
> 		status =3D INTEGRITY_FAIL;
> 		cause =3D "unverifiable-signature";
> 		integrity_audit_msg(audit_msgno, inode, filename,
>-				    op, cause, rc, 0);
>+				    op, cause, rc, 0, rc < 0 ? rc : 0);
> 	} else if (status !=3D INTEGRITY_PASS) {
> 		/* Fix mode, but don't replace file signatures. */
> 		if ((ima_appraise & IMA_APPRAISE_FIX) && !try_modsig &&
>@@ -589,7 +589,7 @@ int ima_appraise_measurement(enum ima_hooks func, stru=
ct ima_iint_cache *iint,
> 		}
>=20
> 		integrity_audit_msg(audit_msgno, inode, filename,
>-				    op, cause, rc, 0);
>+				    op, cause, rc, 0, rc < 0 ? rc : 0);
> 	} else {
> 		ima_cache_flags(iint, func);
> 	}
>@@ -752,7 +752,7 @@ static int validate_hash_algo(struct dentry *dentry,
> 		path =3D NULL;
>=20
> 	integrity_audit_msg(AUDIT_INTEGRITY_DATA, d_inode(dentry), path,
>-			    "set_data", errmsg, -EACCES, 0);
>+			    "set_data", errmsg, -EACCES, 0, -EACCES);
>=20
> 	kfree(pathbuf);
>=20
>diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_=
fs.c
>index 2a0bca5543161912abe2a0236c9fcae7055e62bc..3b8174a91a3451128c0b182e85=
2875d5b73d3efb 100644
>--- a/security/integrity/ima/ima_fs.c
>+++ b/security/integrity/ima/ima_fs.c
>@@ -592,11 +592,11 @@ static ssize_t ima_write_policy(struct file *file, c=
onst char __user *buf,
> 	if (data[0] =3D=3D '/') {
> 		result =3D ima_read_policy(data);
> 	} else if (ima_appraise & IMA_APPRAISE_POLICY) {
>+		result =3D -EACCES;
> 		pr_err("signed policy file (specified as an absolute pathname) required=
\n");
> 		integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL, NULL,
> 				    "policy_update", "signed policy required",
>-				    1, 0);
>-		result =3D -EACCES;
>+				    result, 0, result);
> 	} else {
> 		ima_measure_raw_policy(data, datalen);
> 		result =3D ima_parse_add_rule(data);
>@@ -745,7 +745,8 @@ static int ima_release_policy(struct inode *inode, str=
uct file *file)
>=20
> 	pr_info("policy update %s\n", cause);
> 	integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL, NULL,
>-			    "policy_update", cause, !valid_policy, 0);
>+			    "policy_update", cause, !valid_policy, 0,
>+			    !valid_policy ? -EINVAL : 0);
>=20
> 	if (!valid_policy) {
> 		ima_delete_rules();
>diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/im=
a_init.c
>index d53f4d89a53e56d7ebb31950c10b37fc89782753..7a76e2686267482b10bf854a76=
829c60ef9f1e1b 100644
>--- a/security/integrity/ima/ima_init.c
>+++ b/security/integrity/ima/ima_init.c
>@@ -103,7 +103,7 @@ static int __init ima_add_boot_aggregate(void)
> 	return 0;
> err_out:
> 	integrity_audit_msg(AUDIT_INTEGRITY_PCR, NULL, filename, op,
>-			    audit_cause, result, 0);
>+			    audit_cause, result, 0, result);
> 	return result;
> }
>=20
>diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/im=
a_main.c
>index ab1e53b3210d3a4d3f91d65f7db19e6a2a2d401c..9e80f40680d7be08d14d26ba48=
ed334d4e4ab10c 100644
>--- a/security/integrity/ima/ima_main.c
>+++ b/security/integrity/ima/ima_main.c
>@@ -119,7 +119,7 @@ static int mmap_violation_check(enum ima_hooks func, s=
truct file *file,
> 			*pathname =3D ima_d_path(&file->f_path, pathbuf,
> 					       filename);
> 		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode, *pathname,
>-				    "mmap_file", "mmapped_writers", rc, 0);
>+				    "mmap_file", "mmapped_writers", rc, 0, rc);
> 	}
> 	return rc;
> }
>@@ -466,7 +466,7 @@ static int process_measurement(struct file *file, cons=
t struct cred *cred,
>=20
> 		integrity_audit_msg(AUDIT_INTEGRITY_DATA, file_inode(file),
> 				    pathname, "collect_data",
>-				    "denied-hash-algorithm", rc, 0);
>+				    "denied-hash-algorithm", rc, 0, rc);
> 	}
> out_locked:
> 	if ((mask & MAY_WRITE) && test_bit(IMA_DIGSIG, &iint->atomic_flags) &&
>@@ -579,7 +579,8 @@ static int ima_file_mprotect(struct vm_area_struct *vm=
a, unsigned long reqprot,
> 	file =3D vma->vm_file;
> 	pathname =3D ima_d_path(&file->f_path, &pathbuf, filename);
> 	integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode, pathname,
>-			    "collect_data", "failed-mprotect", result, 0);
>+			    "collect_data", "failed-mprotect", result, 0,
>+			    result);
> 	if (pathbuf)
> 		__putname(pathbuf);
>=20
>diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/=
ima_policy.c
>index 68d9a5e6c232ea0678e9f51f105cebecccccb43e..9013c962dc0bfd6184948230ad=
6746e71f6e82f5 100644
>--- a/security/integrity/ima/ima_policy.c
>+++ b/security/integrity/ima/ima_policy.c
>@@ -1992,7 +1992,8 @@ ssize_t ima_parse_add_rule(char *rule)
> 	entry =3D kzalloc_obj(*entry);
> 	if (!entry) {
> 		integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL,
>-				    NULL, op, "-ENOMEM", -ENOMEM, audit_info);
>+				    NULL, op, "-ENOMEM", -ENOMEM, audit_info,
>+				    -ENOMEM);
> 		return -ENOMEM;
> 	}
>=20
>@@ -2003,7 +2004,7 @@ ssize_t ima_parse_add_rule(char *rule)
> 		ima_free_rule(entry);
> 		integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL,
> 				    NULL, op, "invalid-policy", result,
>-				    audit_info);
>+				    audit_info, result);
> 		return result;
> 	}
>=20
>@@ -2421,7 +2422,7 @@ void ima_measure_loaded_policy(void)
> 	rule =3D kmalloc(rule_len, GFP_KERNEL);
> 	if (!rule) {
> 		integrity_audit_msg(AUDIT_INTEGRITY_PCR, NULL, event_name,
>-				    op, "ENOMEM", result, 0);
>+				    op, "ENOMEM", result, 0, result);
> 		return;
> 	}
>=20
>@@ -2440,7 +2441,7 @@ void ima_measure_loaded_policy(void)
> 			result =3D -E2BIG;
> 			integrity_audit_msg(AUDIT_INTEGRITY_PCR, NULL,
> 					    event_name, op, "rule_length",
>-					    result, 0);
>+					    result, 0, result);
> 			rcu_read_unlock();
> 			goto free_rule;
> 		}
>@@ -2454,7 +2455,7 @@ void ima_measure_loaded_policy(void)
> 	file.buf =3D kmalloc(file_len, GFP_KERNEL);
> 	if (!file.buf) {
> 		integrity_audit_msg(AUDIT_INTEGRITY_PCR, NULL, event_name,
>-				    op, "ENOMEM", result, 0);
>+				    op, "ENOMEM", result, 0, result);
> 		goto free_rule;
> 	}
>=20
>diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/i=
ma_queue.c
>index f89f0ca3d4edf16a7147b3c23d25fc2cf18044c6..8d3282ff7da4131ae4389bf832=
442285e500542d 100644
>--- a/security/integrity/ima/ima_queue.c
>+++ b/security/integrity/ima/ima_queue.c
>@@ -292,7 +292,7 @@ int ima_add_template_entry(struct ima_template_entry *=
entry, int violation,
> out:
> 	mutex_unlock(&ima_extend_list_mutex);
> 	integrity_audit_msg(AUDIT_INTEGRITY_PCR, inode, filename,
>-			    op, audit_cause, result, audit_info);
>+			    op, audit_cause, result, audit_info, result);
> 	return result;
> }
>=20
>diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrit=
y/ima/ima_template_lib.c
>index 8a89236f926c10af0dd2b2ef08fbe59bd8a78b66..9bd80ca1159a2fe24b3ea3308a=
118f6beea733cb 100644
>--- a/security/integrity/ima/ima_template_lib.c
>+++ b/security/integrity/ima/ima_template_lib.c
>@@ -392,7 +392,7 @@ int ima_eventdigest_init(struct ima_event_data *event_=
data,
> 	if (result) {
> 		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode,
> 				    event_data->filename, "collect_data",
>-				    "failed", result, 0);
>+				    "failed", result, 0, result);
> 		return result;
> 	}
> 	cur_digest =3D hash_hdr->digest;
>diff --git a/security/integrity/integrity.h b/security/integrity/integrity=
.h
>index 0c581c03c5da72d80e9c352a7adff1fb89628644..2ab6b7e34e7ee2dd29ae03ae1f=
b45fa26d9c032a 100644
>--- a/security/integrity/integrity.h
>+++ b/security/integrity/integrity.h
>@@ -218,7 +218,8 @@ static inline void evm_load_x509(void)
> /* declarations */
> void integrity_audit_msg(int audit_msgno, struct inode *inode,
> 			 const unsigned char *fname, const char *op,
>-			 const char *cause, int result, int info);
>+			 const char *cause, int result, int info,
>+			 int errno);
>=20
> void integrity_audit_message(int audit_msgno, struct inode *inode,
> 			     const unsigned char *fname, const char *op,
>@@ -235,7 +236,7 @@ integrity_audit_log_start(struct audit_context *ctx, g=
fp_t gfp_mask, int type)
> static inline void integrity_audit_msg(int audit_msgno, struct inode *ino=
de,
> 				       const unsigned char *fname,
> 				       const char *op, const char *cause,
>-				       int result, int info)
>+				       int result, int info, int errno)
> {
> }
>=20
>diff --git a/security/integrity/integrity_audit.c b/security/integrity/int=
egrity_audit.c
>index d8d9e5ff1cd22b091f462d1e83d28d2d6bd983e9..2dd2d7e3916e7bf35c75345031=
5ff22e2d0292b7 100644
>--- a/security/integrity/integrity_audit.c
>+++ b/security/integrity/integrity_audit.c
>@@ -27,10 +27,11 @@ __setup("integrity_audit=3D", integrity_audit_setup);
>=20
> void integrity_audit_msg(int audit_msgno, struct inode *inode,
> 			 const unsigned char *fname, const char *op,
>-			 const char *cause, int result, int audit_info)
>+			 const char *cause, int result, int audit_info,
>+			 int errno)
> {
> 	integrity_audit_message(audit_msgno, inode, fname, op, cause,
>-				result, audit_info, 0);
>+				result, audit_info, errno);
> }
>=20
> void integrity_audit_message(int audit_msgno, struct inode *inode,
>
