Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020102.outbound.protection.outlook.com [52.101.196.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C453E0C4D;
	Fri, 29 May 2026 12:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780057058; cv=fail; b=iGJQk8mQGjmZnUYQJqpoaL05hLl91mOzajFoLCxCCPyp/KQZRFrIyuv6CIkcT2MFQa/imLquuyJx204ojNmTWV+dt69LoLJafSq4G3mEKpGGljOmOpllrN0w4E5uEUspl6B2WJ7Anj+CbDJpYk27Dw6coMvmkJGE6p1obAUJmmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780057058; c=relaxed/simple;
	bh=PbWAD5EkEr9Sx9VBGK7+N70FMorzu938A/N3g3jdApY=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=ID6ubgJqMWopBSh91YjMtfFWQxFHD/S6yV2zQIK3fLjXXVO0JA6hs5sB0Sx9/Ih0Ll+BrY4DraI9IlSvZ79ckSzhRwSONwbmD9rkT+Eqb1W94tjJzl9QPEBJLdWGW/QNEKM7oGFpEt2QYuWmiKX/uRn2ESPQeX+KVFsnmQi/Fh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=Qejs6ALE; arc=fail smtp.client-ip=52.101.196.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="Qejs6ALE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aaiaGRKDvRXOOTGz8XfAjWTk4jfcamwkkk05Xs3sbpsqpmyPb1NNhtvogRsyU9CgWqMbwhL+sNCkID8bc4jFN2xDvIAL8dS6vn9qHEQvjVj66twgpsU3onVM3QkDBblGoRedOM+nTdUhq/7d5HgBa/vv8kKBdzYeJYHEyR+sFA7QzWzpdJsKZ2ar8Jxz8acsjY707NzgE/fbExvk6+uicPoHnqg4BQzyqSTlue9VGIguNQpxDbPGNnJA352KUxb8qeF39j37ogUTycM2Yba55sqntmYMdZxxV1WTuLkS/+xhW58NcRNqMi+m1Z7Y0KMN59HKv/knePQmg31uzLbArQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QgTdPpN/3c6qVBBgJo5WPnv1Rcy3crXnC9PcwwsjatA=;
 b=KYFhfJ+NrUjtoHg046pFmFvA1zBVzi2bg1SQjkhlP0Iq78L9/dE2V/bGYJdIpLu7V0IZIF5vQ9EQjGq/8b6WizdPaptb6hd4hSa3JLVYvJkA4NEtNfcP8POS/bU0sKzn/ypeC/+topkLv1wOgSfxGTZ1SXsHYqbGBUcDMSXm8nQDJu4ZZ70sr2ZgvoQRFXaREuOt/BC2QsUBgxT7xaetr79kKAzsyVYgzf6qzOQq5pye1gn6v2otAW7demxpf8PHgJcjkV8RMtCQIg6Xj8njNsTMrr9cVz7zJKRsN+iaN6Ul/OD9KETZnr6NZrZJk3zFFHKJpJEQXyV+TEVEGpSDRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QgTdPpN/3c6qVBBgJo5WPnv1Rcy3crXnC9PcwwsjatA=;
 b=Qejs6ALE6HM2t49bTj1BscjrpkaiCthZZGjO1Qf3LKqCuvumITRxxyFpFiObE9KCa5wUSEfbyr4IdfvhDbFLASL7JraS4nH0XVvQ/H4ecaMveMHzynqh8ZaXhJJjO6NAZhhF8Pbj/hRTbQtHkBC9wkKr7fIKgxkCzSN/RKLAmKM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LOVP265MB8757.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:489::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 12:17:32 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0071.014; Fri, 29 May 2026
 12:17:31 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 29 May 2026 13:17:31 +0100
Message-Id: <DIV5K84D9V9I.1CWPTKL9GZG1U@garyguo.net>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "Jann Horn" <jannh@google.com>,
 <linux-security-module@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] rust: task: clarify comments on task UID
 accessors
From: "Gary Guo" <gary@garyguo.net>
To: "Alice Ryhl" <aliceryhl@google.com>, "Paul Moore" <paul@paul-moore.com>,
 "Serge Hallyn" <sergeh@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Shuah Khan"
 <skhan@linuxfoundation.org>, "Alex Shi" <alexs@kernel.org>, "Yanteng Si"
 <si.yanteng@linux.dev>, "Dongliang Mu" <dzm91@hust.edu.cn>
X-Mailer: aerc 0.21.0
References: <20260529-remove-task-euid-v4-0-07cbdf3af980@google.com>
 <20260529-remove-task-euid-v4-1-07cbdf3af980@google.com>
In-Reply-To: <20260529-remove-task-euid-v4-1-07cbdf3af980@google.com>
X-ClientProxiedBy: LO4P123CA0010.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::15) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LOVP265MB8757:EE_
X-MS-Office365-Filtering-Correlation-Id: 76b6b6bd-9e7b-4115-9240-08debd7c4206
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|10070799003|366016|18002099003|6133799003|3023799007|4143699003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	8H27ZeW9/rm9nEqyguMbajQzLaOksRv2cqFrSds8grphm/X+9JAja07y4G+wT21JOZt8zhc6r3BHkuoPj/qt6sSiGeGmyixuESqYXx6ywLn/6JuMYUyQU6GfwuUQu1EKatSej4rHjti25j6FOy1M9Re5YloCFjTnkT+6/XcmjmtJplMCogfhqdjKOjvt+7yFeHgJ9yb52MUnu4QokdBfqvI4ZpmcAmrEGgfIIDKT1d5y5DPaUg6nv75xSio3joUmqBQe5UkS/zi0XchlceppItZLtKdWQu4aF5nRQ3hvZnsjYU59junyjTaa4/wBYfRLQJz4Fbewg+XmTd6Boyo6Y9MUD64yIcpbIeZ6Ug0ufcVsvdRj2IvNw99QquMQ31pudp6fMJCxu9JoSKOjBKQgssDFFcIV5EMQvK1zzo94vim+aKoU5mrGb8nvYt6zoKDcpH/SFSgzSrY6S7eaqMJjqo37EXdUQ2M+cLAjFPmwxN6Ly8iqqnF51XINSO8BlzjAu9yfVsrE6Wz0K/rIgg6piq3hVohyf4JIg0AUyaWpSElrSA1RCjedM7h/JqSpj9TNYFS0Rg39bf4p1a1KSuHD7FpJ7avILo0qBD0oz1/GEzZ/PvFH4frTkgWDto4l12C5pM1836c/W0knqhJt2K0fEN83rxceOlgZZWgokGVZAgLESasXmUPuCUKDoOWMSfVmGMh3aHeaI5l5uidHKc682Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(366016)(18002099003)(6133799003)(3023799007)(4143699003)(22082099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?LzFYKzNjYk1IaTJ3NitZN05WTDBCNjc2YUc4ZFFoMXg4aVkzeVdmZTlwbmkr?=
 =?utf-8?B?NWFsNmRuYjZNdWErK2g2L0V2Y0ZWa3c4d29YTzRlaEd0Y0dFb2Z0VW9mUFdh?=
 =?utf-8?B?ckdmL2RlaXdEejJ5eHdXVkVTYVF1U0FSNFJYRHFGZ0tHWTl0WXdod1JNUFY2?=
 =?utf-8?B?eVo1SkJpaytsTFlmNTM3QTZYcUsxQjBKUXNDOHU4T0lWazd0TU5OUmhCdEdH?=
 =?utf-8?B?cnhSSU5VU2FJSCtCWjZnZTlsOTFaeFZKSnN4MEtsUXBEdHR2ak0wTitNbFBh?=
 =?utf-8?B?MDJlL201Vm8rb29YaFd6Rmt3YW5sNVB4VUp6OUxYQjlBZ1k0WjlCSmg0akwy?=
 =?utf-8?B?Y25hQVY2UjJUcHNKaTl5cFNmUFk2U0hOcmV0R3VJQlN1bDlMaml6Nktvancx?=
 =?utf-8?B?UmZWdnNNU3A4UU1UNFFQRDJMenJzZXFPVzIzU1cyYk5GSVBHM3UyVE9WUWhh?=
 =?utf-8?B?Rm1ERWY4ei9vVnhTTXQyZkR5YUo2RzEvc1BuUDMzeWRHZ0hSTTc0aDZvRjVI?=
 =?utf-8?B?c0dYUVMwNjZiVWQ5MlBPTkMrODliOUZFMDE2NTUzY0JlOFc2Y1FTK2JOUitV?=
 =?utf-8?B?Z0FoTVhrR3FyZWNJME9FbHduV2NockJZWEpQcHJzOFc4c1pnT3NaREZxek95?=
 =?utf-8?B?ZndicWdkYllJOHQ4YlVXYjJhL2Zlakg1VVZ0RUZFcU11SkFOQzMxY2RPM0h3?=
 =?utf-8?B?ZGdhZkFya0pLdTh2bFdNOVZhRm8yQ3VyU1grK0g5QUhuL0Vsd3RxTFBrMDM0?=
 =?utf-8?B?VmVIQXVwbVYxei9pNXBuODhmKzgxQnhpQk44T2dvK1VmTVhJZnFmVjFZWHZp?=
 =?utf-8?B?TEp2VGVCOHFNU2dJNW1FYW43VTA5dEhOYm9aQnFiM3MwRlJnTjVvS3FkTzZF?=
 =?utf-8?B?d2l5VWM2YnE3bFJ6K2R4U1hNWVhzd0JYN0ZIRlRNditZRm5weWNIYnRlM0Vt?=
 =?utf-8?B?MXN3MFJldEpyK0FEUncwZU5LdUNHNno2YW53bXJkNXFGUGw5b0hYOVk5TXZZ?=
 =?utf-8?B?ZHBBcEFaVTBOcHJYZk5XNHMwTnVDR2gyNEhOT3dpemdTV2FqRkErQkM3WUw4?=
 =?utf-8?B?MTM1SFJ0aUg2WEg0U1FKdTVxbGJkdjNrd0l2Q1NjR3N4Y2tWdEwvMGRVd2Zm?=
 =?utf-8?B?UmcyaGw0UkZJOUhCM1Y4TUxNSHZZTXdoRHJOSzhpcTYza2lBMzNZM3RaRUpr?=
 =?utf-8?B?UzMrOE4xeGxRMmhKc3EvdEl6KzhLbDlEQnFWci9oNk1iK2VrVkZLL1Q1OEZr?=
 =?utf-8?B?Uk90M3hhSmh4cWF5OC9PVVljQ25lbFhjemo2bmg1cnhuR293dkZzMFBDR3VS?=
 =?utf-8?B?M3RkNHhvbXFsRlNQS1p2dzhSSGVxbUlXRDY4SHcyenA3d1lRNDdTbWxSalhT?=
 =?utf-8?B?d2JGV3VUWGh2dVpYOXppOTJQaUU1RWZyZitjRUF2ekllUWhxZk1YMGFBd0lH?=
 =?utf-8?B?ekRVNlRQY3JMeFdobEc2QU1uQjhqS2x0OW5Sbzl0bEswK0tndU4zbmx5ZVA3?=
 =?utf-8?B?VytvbWtQWFBPWjYwaHZFVHFyb2lKekgzMzA3VzYzTmkzMlI1WkNQTGt6d3N3?=
 =?utf-8?B?eTBvS3RKNk1QaXY0Qk9TQ29wZC80cWt0K0piNHpzTDNCbmZ2bEZBKzc0a2hr?=
 =?utf-8?B?S2lMOHlVWk4zajh0U3VmOEhlY3JZOGczZWlPM3Q0QTI3S2FUQm5ONUppLy9C?=
 =?utf-8?B?Qlo0TlZEMkdadWx0ZXNrdzZuSTFXcFcrdm9LbVREQkQ0bTJUNjlnUExxb2Rq?=
 =?utf-8?B?T3JXdlNta0ttc1l6b1AvaCt2SkRVcW9pcjFrclk5bTNZZ3djTHRwd25RNGRW?=
 =?utf-8?B?dFpXWmNLM1Rmb1BMMWJpNkJNb1lPVVFhbXJaREdhbm5Xb2tnU3ZiMFRNNEpK?=
 =?utf-8?B?cHVtcUpHcnI4b0ZUREJ0UlgzYVdaSmpJTWlnSFg3L1dDeVFrTkFZa3pQdVpP?=
 =?utf-8?B?YmVzT0MveFpTdlpJT0xLMk9rM2M0SSsxcGxDNkxRc2N0czFMR05ZenNzYTNa?=
 =?utf-8?B?NEZWa25iUDVwK0pQdCsxakNsekRLeSs5Y3BjNElJYjB2aEc1U1p1RXdWaUVM?=
 =?utf-8?B?eGlmTmdhdk1ZRHc2MDRuZGF2Q2xVanNBb3QvanRpRFZ5dDNJTHh3SGNnbkhv?=
 =?utf-8?B?THhVakJjL3M4NWNYYVlWbVI1WUJtRjJabm9MV3NpMjVQQWVMeVJTMU5PYjlH?=
 =?utf-8?B?eXhwK2ZFQkxlKzRyb0dzU3ZGT1lXeXhXNTZacVdEMlp5MjYrblVvTzRQdFVI?=
 =?utf-8?B?czdybktIb29QWW84blpUQnJHVUs5YUpoQzgwc0tVT1lCMUl1b2RKc1VCWDNL?=
 =?utf-8?B?Rlpya0h4R1oyQ1ZYNjB1ZGVQbTBoRmZUZXZFL0h0bHV0RzJHQmxLUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 76b6b6bd-9e7b-4115-9240-08debd7c4206
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 12:17:31.5044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x6JKi+IcpB5E9NGcTDwSG+xKrikiRWRVk8jvQXJh7XXJ79kloHgw6fMMdtSFGwxMu81ElPhxOorjWVTzEh0OHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOVP265MB8757

On Fri May 29, 2026 at 10:33 AM BST, Alice Ryhl wrote:
> From: Jann Horn <jannh@google.com>
>=20
> Linux has separate subjective and objective task credentials, see the
> comment above `struct cred`. Clarify which accessor functions operate on
> which set of credentials.
>=20
> Also document that Task::euid() is a very weird operation. You can see ho=
w
> weird it is by grepping for task_euid() - binder is its only user.
> Task::euid() obtains the objective effective UID - it looks at the
> credentials of the task for purposes of acting on it as an object, but th=
en
> accesses the effective UID (which the credentials.7 man page describes as
> "[...] used by the kernel to determine the permissions that the process
> will have when accessing shared resources [...]").
>=20
> For context:
> Arguably, binder's use of task_euid() is a theoretical security problem,
> which only has no impact on Android because Android has no setuid binarie=
s
> executable by apps.
> commit 29bc22ac5e5b ("binder: use euid from cred instead of using task")
> fixed that by removing that only user of task_euid(), but the fix got
> reverted in commit c21a80ca0684 ("binder: fix test regression due to
> sender_euid change") because some Android test started failing.
>=20
> Signed-off-by: Jann Horn <jannh@google.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
> Originally sent as:
> https://lore.kernel.org/r/20260212-rust-uid-v1-1-deff4214c766@google.com
> ---
>  rust/kernel/task.rs | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

