Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021143.outbound.protection.outlook.com [52.101.100.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3284D2F745E;
	Thu,  7 May 2026 11:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778152121; cv=fail; b=f6c+M+XweyWhO78MLqYO6NYOQxiraj7SjCEfElTUICSGhnsAFtmmbFGvZLHIB2tsLk9yHfwt66Dsdta2DqosqqpU9vOUtaGxxRMN/Avuky1Bi/IiDtXoiI8SkqV40BfmvaxoS6JlYxp8zJ5oofscB6RT9hNc/HcwYOL8oA66V1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778152121; c=relaxed/simple;
	bh=Ff7jDVZTQr9pZKzl86vquJzCjlON4scINTd3iDOygcU=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=prTIfx/bKKHXhkJv/wgEbzGXC4mrpAaAVqZGLwP9ZK4G4HMOUCS8+JHcrvJ9T9UD7iJwo2+xCcEIYSwq+DEJteOuE2sK3JYNAEELJ5ZVto5MH1ASr1sH9T5gM+7OL7Nxr/qZFGmnzAWhY2rBdPg7HOOHDERA1/l8HdkWzYGspYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=SbPZ74Wo; arc=fail smtp.client-ip=52.101.100.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="SbPZ74Wo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w1hxQEK9nC4p6husdnG7u+ND1ZK/rgD4DjE5y2x1FQUZ/oOWQpwtuu05V3FuMYWSN/O6E6JwUfQw30hQA4wFI3Jn2KMLadzbbiQL5ZLgejNWDtKUad3jQ4QfTr4fQwD6j05bH/RpzRebF0VkQL8bLYIMZGqH0rsoGct2/7GcTCUSns3jpHGc1fHA+ZNb/yDWSWJdmmWOjACq7puC8mYZLlTXh2pftr3G1l9y+uTceSBdC+gAm+DHKd1bSMnti45awEcKY7wfbR+N5IjsReWpr2jPPBJuv1DIh2he6HQpRKY/zwSIalmHKIKiXKrwMjh27Z0f13OBF+KwTZFt6Mk9Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dFhFkepic72SnbkwZb1WtQe9KI2Jp1xBn/S7W4h278g=;
 b=hEdAHs3BS0M4OtqiPzdhUfe++4Zd3awqFqWYhDEmXgNJwirXkAoa2gnx/4oJfiAbSUEGJKNtFFY9X+VdIB5fUkcVrxmJ1/y6IR/Wm3X0SOaI4tlJ9U6ywIllzNmY76ZAi21Q/28SJEPtBG2QOgBShMoYAjJCQG36Thhxtn+iv1WtyBLhb8FwzilRInFCAb4YcOvi2dnn1Uuq+peLmUnfFqcAjDarDsTa9f321d5wMkPLIXhE9+K3odyo9MC0UAz/WguB87LiN4/6FuozA454guTCUTre3SwGQP52dz0dl2WyrMlODp8+eb+zaxomt2sAAr0uc2Y5fsRLCTBl8zvTgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dFhFkepic72SnbkwZb1WtQe9KI2Jp1xBn/S7W4h278g=;
 b=SbPZ74Wo63I+b6bBTBp9558uLX41SgrPz2P2wxAqU1D/wXjZsY+VBBkYgQ5bzZKpRD/Zl1IeyD1iJx9mlRHTbOX6lzsml3MBgdR3ZnFubE87oUXqAD7O8j6vrJDBY61uMQder8G34TjwMAuJWYVMBYGHvcRoyJ92PL7A46NFju8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO9P265MB7920.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3b6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Thu, 7 May
 2026 11:08:36 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9891.016; Thu, 7 May 2026
 11:08:36 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 07 May 2026 12:08:35 +0100
Message-Id: <DICEBGUAU4OT.244JDJIKXRHBS@garyguo.net>
Subject: Re: [PATCH v3 1/2] rust: task: clarify comments on task UID
 accessors
From: "Gary Guo" <gary@garyguo.net>
To: "Alice Ryhl" <aliceryhl@google.com>, "Paul Moore" <paul@paul-moore.com>,
 "Serge Hallyn" <sergeh@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Shuah Khan"
 <skhan@linuxfoundation.org>, "Alex Shi" <alexs@kernel.org>, "Yanteng Si"
 <si.yanteng@linux.dev>, "Dongliang Mu" <dzm91@hust.edu.cn>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "Jann Horn" <jannh@google.com>,
 <linux-security-module@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260507-remove-task-euid-v3-0-27f22f335c2c@google.com>
 <20260507-remove-task-euid-v3-1-27f22f335c2c@google.com>
In-Reply-To: <20260507-remove-task-euid-v3-1-27f22f335c2c@google.com>
X-ClientProxiedBy: LO4P123CA0073.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::6) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO9P265MB7920:EE_
X-MS-Office365-Filtering-Correlation-Id: c6b1dd7a-21d9-4e70-c7c3-08deac28fc14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|7416014|3023799003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	0BVL5tdeth93V+3Xflzwbt/qqnRwlQIE70qCKKC3OTuEVu67Pdr1QL4EIf/HmCQpJBKySC+aYMTs/Zx/8o6R7+Ap5uNBPRdkeyOl1l5AmDv3nljRYOCk5ab+WMiHphAIxMvp0pt5ITKScgllXf5VsBrgIPDkz6mPK1sw+KivrNbffh7KytkyccYIkVKnkdu5sAVA3gioop+JcloGEd56+hgnAH/ljw6Q6zCAyw2bOTU6QFnYCFqW4vjYllkJCNo4gCXk3i1fe2oCt3hDImzRFL5WsZSpdBiRbIG8ORGgiNvzRFp4pnoQb1W/ecZ51/VfciITNSyLqzcNUqRml89Jrl8TUhLqEUNYnsn6MHo8R9u9SdSnGuvDg1rmcUWG11UtEOKK4AhUZ3PQpGGf+kYwsfQg1Wl3cFv3CrROkufqCg41AVElEr+GeaCqfANrxyw+qAKg1AN3lt4y9wUACBgC2o+t+zZlMIda0ryVs1iBM6IK+BxwJdkAva2/uHMfwkgz8zw5I+89ltTXTeO+j1VbUxOWmE9evq5ZF3Z+CZ2JxqPPCJIH2cyv9DwOPpyASMEqo+G5evmHi5MTlH9VwHGOliw4FKi5VXKI4Bj2cM9Mb0o6kNf+MXV7dQZS3s7FxWzqvQnadjTYew+qoo9eAeQu1krGK5VI1w0yFvMMqkolOoSIE51qDYBq28kX2uLpUtKV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(7416014)(3023799003)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWVvRVV4UUtJcU9JbFdHUE5WVVJBZ0FxWDJpRmQ5RmZSWk9BelV3ZEJxUG5Z?=
 =?utf-8?B?cHRjSkluMGQ5Y2wyaXhGZnN5V0UwSHZHYzRzNVNxRkNTeFdqZUZWa0RrdEtz?=
 =?utf-8?B?YnNZdkpIWUtxRWVwK3pLQ1RzOU51ZVJLNjFmK0J4NytTUFhoMTRKSm1zY0N0?=
 =?utf-8?B?dnd0TitwUC9UUTZrQkVVUGo4RWd5RFJHNHZkNlIweXdJV1liZFlUZmNLamQz?=
 =?utf-8?B?TFVock5TTkRvSnJiRHFtN1FiYzBkZFdiK0M5VFQ5a3g5emQ3Z1Z4ckpVZnFx?=
 =?utf-8?B?VDlQV0g4Q2oxbi95L1doNUNhdnRwTU9mOXRjTEFjZVVVampxVTFQRnNQNWFn?=
 =?utf-8?B?a0MzNGhVM3NPb1grK2IzRUZvY2g5WEJqUk1nWXVsL1hUaXZNMk9OYkUyM2g0?=
 =?utf-8?B?N00rNW1nQlJqZjRPaUNqUHhUR3lDZzRCZTk4N25WdFEvSEFjNG4vSDM4aUl3?=
 =?utf-8?B?R3U1NnNDVDQwOXN5MDM3V2tVc0I0b1hzQjB4M0s0QUpRdElYVjZGb0p2SFhJ?=
 =?utf-8?B?dEFYL0hLYmZMN3J0YThpcW1DSEFxNm1OQUcxSml5d1dSQmNlUm82aVBmeC9P?=
 =?utf-8?B?WHRKaFFML3Y2bEl5d2ZFaXMwWFVyWGRYekxFZTJMZjdCbDA1dzZCWjVvc1dX?=
 =?utf-8?B?dGwwN2lPSmludmFvQXcyZzJEZkdZb0J2UVcycnF2ckttRW1ROWl1UW1lY0dh?=
 =?utf-8?B?Kzd2WjJpTmVwQTAwd1RKejZETzQ1VE9xKy9aVjVwV3NqTk0ya3M3NDBnRWhV?=
 =?utf-8?B?ek5JblF5Vk5lVnl6U3FENUVONkd4b3NYTXNZbmlER2dOZ04yaU1uRkJrWHUv?=
 =?utf-8?B?Z2JCU2JOQnFFL2w4c09sMU5XYVh0akxSYm1ueFpTbFpFZjhJWFJRaU8ySk5i?=
 =?utf-8?B?bW5IcnlQRFVqRFV2UG0wa1p5Q3E3TFBsVTYzbHlUUkQ3cGs0S1pBaGZKM1pD?=
 =?utf-8?B?c3N6dDEwWXRzNllVZzRERlB0eTJNU29uN1BWNTdwKzFTMDY5WjRLemR1VlI2?=
 =?utf-8?B?OVV2QmVaMWE2SXBBdjRkcExxSUkzTGUwNkJhWjc5U2ZFUDJGS29tTElqL1Rw?=
 =?utf-8?B?blJvRS80NEhqaEcrTjJjM0kwdm9MVHhEbU9RQVRoR2p3TGNtdEoycWNqM1Yr?=
 =?utf-8?B?MTl1MTVQWVJBYW9IV21ZaThadkdkM3M3TTFUZTNybXgyQVZRVmFadmpNM1NH?=
 =?utf-8?B?THNYVHJVZHJ0c2RZUnNxQWZJYy95YnE2NUV2eTBpZ29nc3IrVjFMS0FPZ0hw?=
 =?utf-8?B?RFN2eHVoT2Q0d0dIOE1Vc3RRM0wzdWNVSGZIZDJsd05ZRlBaOXVoNm1CQmVQ?=
 =?utf-8?B?Ym5uQ3QyUkkvNEFFSGZ4SmcvKzdVWXBlSDBob0dNVXB6blVadUJrQ3F6eUVB?=
 =?utf-8?B?WHE5SDlkZmI2cW0ySU9LaXZRQkFaT2xvdEpiZkdEK2k4QTVTN3BEMmhTcFZF?=
 =?utf-8?B?dGhHSnN1STJ5ZEFBWXQ3b3VEOG0yZEJOTDZjMTdlZ0w3K1BsVFBSNm5lOTR1?=
 =?utf-8?B?QmVDZ1ZRajhlQ0NjMG4yVUVoSnV1bXRmRjNRR1JnT3IzcDZPRVQzSTF5OXBi?=
 =?utf-8?B?US84OUZ0a1RSR1RiZGE3WndKUElrd0RYN0Q1MXVZbkRhUWYrVzFibG9CUFhZ?=
 =?utf-8?B?ZXVOR3NndllOY1RWZ2h1MFJJMFYvSkp6MXFtd0dvVERYdUVlNnRMOFJ3Vjh0?=
 =?utf-8?B?RUhMNkRESFp2TE0xTjZ1akhadW11eFBTWkUzM0trOThlK0FTQzBZTHhyU05v?=
 =?utf-8?B?MVBSUkpKV0ljdUo1dThpeVVIR2tVeklwWFJTOTlYNGhWS0RQQWhmbkEvbWlI?=
 =?utf-8?B?alR3b09oN1lHaVJKQVZOWmRVc1hrTTlCUGI4NEk0ZVVmWXJrb1RHSkVrblNk?=
 =?utf-8?B?NUFaaG1CUDMvZEgwaEg3OUhQUDJ3MlhZMTQ0SGIxLzdHS21KZUNWL200Smhv?=
 =?utf-8?B?d0tiNVhGY0x3SDFTSWhZSDhNZlM0dVhwLzdDVk9odlBpWm9YdlRXUVdHaHdw?=
 =?utf-8?B?cXlCaGJxcHkraTFselVSb1ZKbCsyREl2L3YwWmFzYnVQdkpETVVQelJLd1dH?=
 =?utf-8?B?bHpOcVFSelkrYVIxOCt3WS83YTBNUkZtKzBYZ3dGb0MzazNIYnAyNmhtV2w0?=
 =?utf-8?B?YnIrRUEvUmp6b3J5ZEVRd0lrOTUyYUxud214TlBOWXZZSlFEMzZtL21ROWZl?=
 =?utf-8?B?ZzVtSGc0MjdoMmVRVG1hQUE5OWt2NzhWTnNRc0g5NTIwZ25kVytjbkpTN29Z?=
 =?utf-8?B?eXoxbk9DVmpGU0xUb0pYOTN1SDFUZ2QybHd3aVN3VHBXVVZGelJwc055TDk1?=
 =?utf-8?B?WUZWQmhwK2h3RHJCR0JySitRd0gyOXJHRTliWUpQTVk0RktnaVZjUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: c6b1dd7a-21d9-4e70-c7c3-08deac28fc14
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 11:08:36.1910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1dbLycsKmYIY5kAFrS/3qJpDUGTiSbWT8fuA5xWNpSHfIvFszAmqli+6RFxh3cGu63MBREIiY0lmXlDrwR+CWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO9P265MB7920

On Thu May 7, 2026 at 10:48 AM BST, Alice Ryhl wrote:
> From: Jann Horn <jannh@google.com>
>
> Linux has separate subjective and objective task credentials, see the
> comment above `struct cred`. Clarify which accessor functions operate on
> which set of credentials.
>
> Also document that Task::euid() is a very weird operation. You can see ho=
w
> weird it is by grepping for task_euid() - binder is its only user.
> Task::euid() obtains the objective effective UID - it looks at the
> credentials of the task for purposes of acting on it as an object, but th=
en
> accesses the effective UID (which the credentials.7 man page describes as
> "[...] used by the kernel to determine the permissions that the process
> will have when accessing shared resources [...]").
>
> For context:
> Arguably, binder's use of task_euid() is a theoretical security problem,
> which only has no impact on Android because Android has no setuid binarie=
s
> executable by apps.
> commit 29bc22ac5e5b ("binder: use euid from cred instead of using task")
> fixed that by removing that only user of task_euid(), but the fix got
> reverted in commit c21a80ca0684 ("binder: fix test regression due to
> sender_euid change") because some Android test started failing.
>
> Signed-off-by: Jann Horn <jannh@google.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> Originally sent as:
> https://lore.kernel.org/r/20260212-rust-uid-v1-1-deff4214c766@google.com
> ---
>  rust/kernel/task.rs | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
> index 38273f4eedb5..7950c3a3950d 100644
> --- a/rust/kernel/task.rs
> +++ b/rust/kernel/task.rs
> @@ -210,14 +210,17 @@ pub fn pid(&self) -> Pid {
>          unsafe { *ptr::addr_of!((*self.as_ptr()).pid) }
>      }
> =20
> -    /// Returns the UID of the given task.
> +    /// Returns the objective real UID of the given task.
>      #[inline]
>      pub fn uid(&self) -> Kuid {
>          // SAFETY: It's always safe to call `task_uid` on a valid task.
>          Kuid::from_raw(unsafe { bindings::task_uid(self.as_ptr()) })
>      }
> =20
> -    /// Returns the effective UID of the given task.
> +    /// Returns the objective effective UID of the given task.
> +    ///
> +    /// You should probably not be using this; the effective UID is norm=
ally
> +    /// only relevant in subjective credentials.
>      #[inline]
>      pub fn euid(&self) -> Kuid {
>          // SAFETY: It's always safe to call `task_euid` on a valid task.
> @@ -371,7 +374,7 @@ fn eq(&self, other: &Self) -> bool {
>  impl Eq for Task {}
> =20
>  impl Kuid {
> -    /// Get the current euid.
> +    /// Get the current subjective euid.

For consistency this should be "subjective effective UID".

Best,
Gary

>      #[inline]
>      pub fn current_euid() -> Kuid {
>          // SAFETY: Just an FFI call.

