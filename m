Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021127.outbound.protection.outlook.com [52.101.100.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21696257ACF;
	Thu, 19 Feb 2026 14:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771512189; cv=fail; b=hwgTVX5iYUh0smr1Svc7pe76EslgLBqMNChBCarjbqbjefcp7eajUSd+6F8whKnu5YSoYAL7rX5c2wdPVM/sAsaKBUO4eIv6JdMk8z+YuNyDVpaiUXSs/5OXAsynbQtIrFMVJKZCd/0puwgs7Yr2m+1qFI3Ou0ATrWXYwQ1THsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771512189; c=relaxed/simple;
	bh=w5djUoWxSu3K+BKyVJ+6I9Wjj5PPfXzQhEdn1ncZ24A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:
	 Content-Type:MIME-Version; b=lEQOFrrdhAAOSCkMDjJ392mHbfkMSe/sT5LeLhrkouNXL3YrHPnWIGqwky9hGwNH85m+4jSse5WmGG4vTcH49m2j3LJIv6mNg8bkaXwW9ARKx3E3BADSwvdOq1MT6HBm0WXOXDl7HvAaTrYmSssJXUL+yhLTIR7v2WSrtPMbMzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=w33nbxrb; arc=fail smtp.client-ip=52.101.100.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="w33nbxrb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=St9aGydY6rdPhlIq5035sACub5COGBx2csvxnecWcX1jtfBpFM5OQHJBFoMoS5smnLv52tBreSoT3yUoD9TYxFD6Ncx6s7AE5nVFKQNWP5flNyCtS6UqPHcYwplMqKDBNzV2IIXzSqXxMbft3eTzy+CbnbpKQ7xW2+c956GRngMIPK8bJacRjKg+x7ortAZqoXJn4HEG8Z7jBL96/wCYGW63c6oF76B3HXERBSarpN3zKFQb1aipB5BwS1oh1lxEFiLFLdDIAEe7mGJGNya3kC5X6umHel8MhEpfUb1i1NRBppSFyD+cmzkqd5hh0nenrpE5hkEd7UTEvVSV5/fovA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ylcK5pKDrKmhrJLzHSU358SZfXlzxk9h6WwJP3MlB0=;
 b=eH8+OhcLO6zy54BjBVo0fy+VcfVpAyhUlJcZOBttrm1d2TpVp6XqWp0GyI5Tz1696Q50Tjkrp/8M9whE8VTxaf47f0+qQroEbZ8DjGIla1rmYAsI8zzdyz0U6GA2CBHmkdp1LEBUNOq/onxyzpWkbZTswihHjJtpUYuxuh4poTvHCnRQHT+t5R2Ege7Ah24UReKwCFHQ7FzGu8cH47/JFME4oOwOwhD3V9Hqm0iIkes4NtdM1YGDZDyjWs9NKfI1p3bcONFcASy8iuzYTd3Jro7fgc//z4VTMQ/FMTxKftV6P0xRLgGFBJqdLqskWo9q9b0+aNSp06C8FO4+F4FXcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ylcK5pKDrKmhrJLzHSU358SZfXlzxk9h6WwJP3MlB0=;
 b=w33nbxrbPye4Z0Pu+uOfnEPcBhU+wfhCG0rY545uHlpRwYweN8ObKynWIznVodCGt3Tk2EJIECa/NIkKCej6I/cApQgTwcdyAUcWXq3dQ195G5NdRUSd3qvhgFEl77Cox4SfwhS5t1A993LY5lG1/2pN51M5oVqj5dVwnGN4fNw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB6401.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1e3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Thu, 19 Feb
 2026 14:43:02 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 14:43:02 +0000
Date: Thu, 19 Feb 2026 14:43:01 +0000
From: Gary Guo <gary@garyguo.net>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Shuah Khan <skhan@linuxfoundation.org>, Alex
 Shi <alexs@kernel.org>, Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu
 <dzm91@hust.edu.cn>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng
 <boqun@kernel.org>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, Danilo
 Krummrich <dakr@kernel.org>, linux-security-module@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH] task: delete task_euid()
In-Reply-To: <20260219-remove-task-euid-v1-1-904060826e07@google.com>
References: <20260219-remove-task-euid-v1-1-904060826e07@google.com>
Message-ID: <c10b237bea136e545ee4a76141409ee6@garyguo.net>
X-Sender: gary@garyguo.net
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0287.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::35) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB6401:EE_
X-MS-Office365-Filtering-Correlation-Id: 90916553-f60d-469e-ef3a-08de6fc52eed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|376014|7416014|1800799024|7142099003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CDLjvz1O2bACTdV+ppyy8IWT8sFO86xIZNMYtMkI7yTND/O29PWzfMVXaNxV?=
 =?us-ascii?Q?rAxLLDSuMpVGyYFNJWbC9jXlOem7rtiWYFAkibESk1/mKyXvC7V8wxT7WNkP?=
 =?us-ascii?Q?7rO0urqn69Cvl6g5LSP4Rpuwtb34sAsRudz4Ntn07weJdUj4C2VGjnwa7K9y?=
 =?us-ascii?Q?iZJq0Gb89zfMYXX96t12+eVnw4Hh/g5m1wpnXKwJdwu1H2nKW9zY/LHs0YV8?=
 =?us-ascii?Q?mWo51pRiDGcsxwXTh+OkW9UuyovWoj8GccB5jkC63pUybap/TPeGxwlKWjtv?=
 =?us-ascii?Q?HgtdXkDacFKfFMrWR8cH/Qx4zJR+RzjFYh7A2HOBQ5G3UFVUwW5KXJW/VuDr?=
 =?us-ascii?Q?bt3tkCnIYsKVhfrn/5IRXf6IspSnFiOxxGvVL0eROy+pCyzFrhU/K1GlI+m1?=
 =?us-ascii?Q?dnwxBbAMLJmljm5/XGioemx8OSK1WvJcroRHS/mcqhP121OZ1UZgqtWPfBSK?=
 =?us-ascii?Q?jQSGKb5XRSp9zJ3u4NQ4ZPMLGpJvnjbP2qEKXvrZxeBywdaOiISkZHs/DYKr?=
 =?us-ascii?Q?zFT36XwU62eQYWmIpZPmDbC7Jt8ElIIkoSrK5/bNse6zq41WeIZIB97P0jLs?=
 =?us-ascii?Q?DmFIEXzFMoBKdKqEQMAOL9wt0bQTW7MoA6lZtn79YlfK2HhQSvByckOC+YQu?=
 =?us-ascii?Q?Te6FG6uC5zjh5Gj/UOjpzM3MLx6zfyG5J9prB4CiHO6AI4m0AR3v8lzkA4Eg?=
 =?us-ascii?Q?goXoWWJ/vtX/h2ErpVC4kRyFL0CcI9ODPpPmqxxa1ZOw97V2PJbEb6rf6f7i?=
 =?us-ascii?Q?9w5Lj84d7d/I//GOOmeiyzYhYf6ZWJNBShwycnekuM6mXsgrFYCZHGlzrRam?=
 =?us-ascii?Q?RCxIcc3XKicZtCaqXYshzIRxf3u8rqPgY4vBV21CwITuEbb2db2TjFFTA6wA?=
 =?us-ascii?Q?IOAB0sUsn6nP8HDCRd42YYjezevjF2Bcrq8reDO6Iax4u1zUxlv/Z2BgrOMg?=
 =?us-ascii?Q?/XMHtgoaGlOpzCGT/NMxwmAeTGMaB/HbnxSmI+e0nx1/afrOYuMyCavvcqds?=
 =?us-ascii?Q?m9B+COv0LoL7fK6CiJ/lt6rtvB6rV7NX2AjkNzP/DrrMwM3Luj7gW/gW8nrZ?=
 =?us-ascii?Q?ZMWOilrcbbmBNHKUZ4nTpd4cQ+ZmEvZzFdbLCcA5yTsG7kSJDiZiobkO7pbu?=
 =?us-ascii?Q?MPAHMDCRI2Ib3vzQps/u7bL/IOu4mCsDUp9j+fK5xEI+bfijzlKfdpLUub3/?=
 =?us-ascii?Q?csBPWp8REBz/qRa/D5s6cz5V0uL85v4qpnzKNLpDVjS1KXnSIvzXafp1gWie?=
 =?us-ascii?Q?qC1OuXZvPbK5FCp7A93H8uCMj9u2RZLWqYNNsO39K9PEot5q3rG+2+N6yHo2?=
 =?us-ascii?Q?qQNms5i66EwCsHvhz7fF7GcPltl7/9BSqVyoM3T+CxVph7Hkgn3do6JpBBiX?=
 =?us-ascii?Q?EIg/pwsZ80V4vvTzcvGO1TevbGVleh3QISVKmS8vBCmsniWlhFlIM6g2NpEy?=
 =?us-ascii?Q?DjK6RYd9aRT+aU6CA6Ga+KkSknExW+WCQZqY8QIc9SdiRNSBbcPak3AFM3d4?=
 =?us-ascii?Q?kEvn7PS9os1ObHpXvWhKG8oIDTmHEV5VoWzj6P+Uq/0o7chc2I6A4788g8/f?=
 =?us-ascii?Q?EkwDTuzSc7sG2G83D3Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(7416014)(1800799024)(7142099003)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Hy6LJZSTrwicRNrOOpgivn4C7TGdovj6JlRFUVRzdW2Ew9BeqMH8suCEh9JS?=
 =?us-ascii?Q?bCdrt/iChcq8BBitZNuGE8LNSHNi79TXg0OyF4gqDQ+SK7XyTe22K9mZXT+D?=
 =?us-ascii?Q?ftovmV5DPss6zT9I/WEftxDIV+UHoEZV4aGhwS0I/LwOgNLnr6NDUJAFINe7?=
 =?us-ascii?Q?GvCEStscDPWHLdyrCqGMmC+HP1ybWYJoLihUpJIanRPp0YPrzspBuEuHplLx?=
 =?us-ascii?Q?6OQKfNR+XOL30ZKS1Ip5Gvmk728Sfj9zA6vkSSWuvCrk1xzzximH7fc+DSe9?=
 =?us-ascii?Q?Sop6ziLNuowdfUnVlNpXKZIGGQyCxc7VX4Q+8mQ5RCqOnb/CMJWpAVaLDlv4?=
 =?us-ascii?Q?EJ9HpCJXQVgoInYNOkNA01AXSkuOjH1pICSzZSFyCny5u2fqmIcVnuU0YGKX?=
 =?us-ascii?Q?kA0SH+u9eqh0B+U0zaBZrQuDSlyfGYFr/lBdRdcPHxrZbRt0oeABYjghiwy8?=
 =?us-ascii?Q?LLax8PhrzemCGbmxSrKxSiYHZpv8wVZtghq83IxKU5r9Fst5R5YbgUQJ+ckv?=
 =?us-ascii?Q?IrBUPuIUgoBCqF04kmKTP14hJmdnPm9a9gDZ+ZqhbPVoNyLc7KayJNhDzG12?=
 =?us-ascii?Q?iLAdpQjsKC4chlMV0nXQkmqo8L+P9jzzbv3uDtkYPsO/DL/lq4ulExkxOdqD?=
 =?us-ascii?Q?ZpdsvZv4rzEUUeK1Hzs/u7k29g8jU8+MctbEY71NLEvduZNVlZhzDqcGt7qp?=
 =?us-ascii?Q?RPv1epZLQORbsDL0XinEdmCQ6wWkmORZRGgOI4xqS0fpFxzEGSVecbM7Mpcp?=
 =?us-ascii?Q?v9uX3n0ZieZT4PqRhVB8FBgZZR1So6eS/MlOcCcC1+9bj7AgAd1BXHwYDKQK?=
 =?us-ascii?Q?JGCznX3snS66+uSLKem9NrbnRiuNduEkmW5yVg4tWmBP86SU3WUuTGjW6Xo5?=
 =?us-ascii?Q?SJ7GO1fFEZg+Y7t113rhA1JmCsYGjzqFWhzFMzWETVUXA3Z0TBdizthZz+Cx?=
 =?us-ascii?Q?zF4qFTEzhgUhZ2BIDV3Gw6v/Q1Cn3DibYutQ9N2bKlMUG5VJBl4IqurklGVD?=
 =?us-ascii?Q?oR6CPAUoe8IgvtGnNyayoxSpjYdZHp7pdGQ+wGfIZm9f15Nd/rywLTKhbRmD?=
 =?us-ascii?Q?DWI9DB2E//1EHT5iEeLvRf1Id0K+RMcvOfVaZPEfzD5d2j63UMl58UCddOwo?=
 =?us-ascii?Q?T1eRvK0o75nu4M0fihuB7hFjLzNBYb8IYA5kMIUfROZJI+Bac3I0HaiUpCqL?=
 =?us-ascii?Q?z51KSnUNJIn7uPOstoUiPCMHCIeyP+CtPAj3CClJCq3z5jbZ3QLKn/M5nFCd?=
 =?us-ascii?Q?o+MmMmV9TBOAmZNKASwNZjxW8iUolLDtutEvOttzmMl1dHtEtlCwbd2rA0Bl?=
 =?us-ascii?Q?7I/zWr7NNIXK9bueeufnYM/0lhCUeDTTanm9WYcs9AccSkkFP26UOwO+Vwhz?=
 =?us-ascii?Q?lkcUdkxJdPvm0MWh4AlABcIiFBtGKVK31FQrIhQ9gYcwqm/czUDDGHu12YSy?=
 =?us-ascii?Q?kQUURseISzuOzvC/9y7y2rkrYTeNMGWAGX1S4pqJOlmju5OVA8Ww5tdTYzxp?=
 =?us-ascii?Q?M8V4ddvpsxZrwU0OFiX5Hb8U1em7J2YzKUmAB7KkN+bnpdLmbw2K7DRcN95w?=
 =?us-ascii?Q?H7MRxFGJMlR9gNqulLvskAUslwYY9S7i9FNT2xaXTm6bKWzrLQreN4jCSrxX?=
 =?us-ascii?Q?1qUESoUWjf9TSidM2l7AZxp9BXIlSLYiQ5NI+1Hxjl9pkmLvJxvCD1Bn5k5j?=
 =?us-ascii?Q?3f1j6CPVBHa4g9K0Hg7jiCPOVr3nminG9A3Ff3jy5mK5oc315RtOBCWN9705?=
 =?us-ascii?Q?NRu9XRsqHw=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 90916553-f60d-469e-ef3a-08de6fc52eed
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 14:43:02.0597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b6Mztvv/IeQ1CHRUFjd1iK4VToQFY856YgD77UvCK7pvxyZMwmRoVsZ29qmPelPtYk+kVZP+a1rIL0UPiil6Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB6401

On 2026-02-19 12:14, Alice Ryhl wrote:
> task_euid() is a very weird operation. You can see how weird it is by
> grepping for task_euid() - binder is its only user. task_euid() obtains
> the objective effective UID - it looks at the credentials of the task
> for purposes of acting on it as an object, but then accesses the
> effective UID (which the credentials.7 man page describes as "[...] 
> used
> by the kernel to determine the permissions that the process will have
> when accessing shared resources [...]").
> 
> Since usage in Binder has now been removed, get rid of the resulting
> dead code.
> 
> Changes to the zh_CN translation was carried out with the help of
> Gemini and Google Translate.
> 
> Suggested-by: Jann Horn <jannh@google.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

With Alex's translation suggestion applied.

Thanks,
Gary

> ---
> Depends on these two changes:
> https://lore.kernel.org/all/20260212-rust-uid-v1-1-deff4214c766@google.com/
> https://lore.kernel.org/all/20260213-binder-uid-v1-0-7b795ae05523@google.com/
> ---
>  Documentation/security/credentials.rst                    |  6 ++----
>  Documentation/translations/zh_CN/security/credentials.rst |  6 ++----
>  include/linux/cred.h                                      |  1 -
>  rust/helpers/task.c                                       |  5 -----
>  rust/kernel/task.rs                                       | 10 
> ----------
>  5 files changed, 4 insertions(+), 24 deletions(-)
