Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A0414387E;
	Thu, 30 May 2024 04:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717042816; cv=fail; b=K/hjIyRoeUiItFZEGUtDo9y7CrbvaTSiPzxj5PcyXHuS0bSx5eDJnRxER56jXWSyinxSKsIkoqss2p9NvX0u+YLSfT/8MNxiZJx0mlaHvA59VF/1oCLC7/fJF4CsKIx9caiv1a7h5el4cI8N9ILD5wu0knTZl9+UHDZhxHYpIR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717042816; c=relaxed/simple;
	bh=rbih0cTvIZXX2q6DW8NMB5OTvyxeZMVxvBNb8Zz0okk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rKOV+CpiTUJeVTAEkEscL1uKU40/IS5xUOYEM6Rw4Q/oJziCmqHjWLY0YH2opS+SA+WFrfpqZehgXUDVx7sVqDz8EALyLA8hreBbELDYqBklGEyfR3HfDzw4Jiibzvd0gTy04KdWT6vBMwjx1EVcYd2iKLCdsnnRSk+VR0xC8Xs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rwxym+tW; arc=fail smtp.client-ip=40.107.236.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rwxym+tW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WGdcDoUMr1Lpoefqb+ZpciWPBV1NRWsJXslLEbyaAeP4LIk9A6K4LTTdpCBtgJ4dYBrcNmTw4104O0GIBdBbO1KazkQrXS/o/sOGzRVJ28QK+SEjzkYKkbf5aBvKa2jXVLpQ1y48cRloS7SsgWTBtTsGZ6am5Ao86/ogo45gNVYH1Lkd0QANruR6xeKxVI5fya6omyxOarr4gCzGMo8z+dXgEm2ZX3T6goIf89metviMqydh9F2voxMMuj1N2BULeNZcG95PBMW3J9JFqxR5HJcuCGg/pIaXM4GFVPE9yYHAbGUnBfnq9QECAS5k0QGMLimYt7Qj8hcy/kk7l/6m+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3UQ9LwD9ilGWna831h/UKLq0KxgajcJZhH8NSCQ1Mu0=;
 b=dLN4qAEU3LQ3kgcCD1LbqEcrOUaTFU1Xp3J5QNqwqRcO+8ljuPIKEPwPuNkqoOt3SmzXZa+2D64mi8DqC2fY7PKkaEFbpmrCGv4orrjnWd8bJbHlrJMWTtPaj+6BW00ZQDpt8sVnHo2aHRbCfMNil8YV6D19a0hyHYXL0Ej/nZwv3vNdUJVYKDAUX14ZU7ByzNhPMhyi7MfKIuy5kfzPeQjN09WXti/IejtnfQ+Qzx8HyPGHfopJkhjyD/R5pCUxDri9zx5/d3bH/P1xSn9YobkfAhxD0S3ibeH+ctUxtLoTaANrrhblgVWDoTgfoGLREtKpVQ3ZmoyIrg9NEQoQlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3UQ9LwD9ilGWna831h/UKLq0KxgajcJZhH8NSCQ1Mu0=;
 b=rwxym+tWijzdkvHoxgxWn5Icn5rQ3bhgOZ9eYXOTxD3jdO/fhtqweiS6mD3rSFiJyMYtw+E5TSXk2IXRkr1lmzfCnaCuwiOCPXojnEp06TRV+akmMY8Bynr7GFtjpSzsrUkvAL40oWMWNsTCj/sNPPkx1kQRUoGOP7mFRJ2N8+g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) by
 IA1PR12MB7494.namprd12.prod.outlook.com (2603:10b6:208:41a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 04:20:11 +0000
Received: from DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627]) by DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627%5]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 04:20:11 +0000
Message-ID: <82556a16-3390-4867-89b6-23e5ff168b89@amd.com>
Date: Thu, 30 May 2024 09:49:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/9] Nginx refcount scalability issue with Apparmor enabled
 and potential solutions
To: John Johansen <john.johansen@canonical.com>,
 Mateusz Guzik <mjguzik@gmail.com>
Cc: paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 "Shukla, Santosh" <Santosh.Shukla@amd.com>,
 "Narayan, Ananth" <Ananth.Narayan@amd.com>,
 raghavendra.kodsarathimmappa@amd.com, koverstreet@google.com,
 paulmck@kernel.org, boqun.feng@gmail.com, vinicius.gomes@intel.com
References: <f184a2d6-7892-4e43-a0cd-cab638c3d5c2@amd.com>
 <096178c9-91de-4752-bdc4-6a31bcdcbaf8@amd.com>
 <4871a305-5d45-47d2-85f2-d718c423db80@canonical.com>
 <CAGudoHFkDmGuPQDLf6rfiJxUdqFxjeeM-_9rFCApSrBYzfyRmA@mail.gmail.com>
 <3b880c7c-0d19-4bb6-9f0f-fb69047f41cd@canonical.com>
 <CAGudoHEycK3iTO2Rrsqr56_Lm69rCzMRaYz11NLrOcn5gKB3RA@mail.gmail.com>
 <5c94947b-1f1f-44a7-8b9c-b701c78350b4@canonical.com>
 <CAGudoHFxma+H_iHPV8+gfEkHc0uwFD8=rJtFy7ZE3TH+7tGiwQ@mail.gmail.com>
 <78cfe966-33ec-4858-b114-57697e478109@canonical.com>
Content-Language: en-US
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
In-Reply-To: <78cfe966-33ec-4858-b114-57697e478109@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0138.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::23) To DS0PR12MB6608.namprd12.prod.outlook.com
 (2603:10b6:8:d0::10)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6608:EE_|IA1PR12MB7494:EE_
X-MS-Office365-Filtering-Correlation-Id: c01ec373-23ff-4a09-2892-08dc805fcb9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WmxTQnZES21QS0V2RnZLdytsczZGYkE2U0k5RTRZZ2hObTl3TXBJQ3IvNVRJ?=
 =?utf-8?B?TTMrWWI1TVNGOENmWFU1Wlc2K1AyUEUxMFBjdnZuSWdRK0tWbVdldGdMa3VN?=
 =?utf-8?B?TXJ3eVRDc2xLS1NBZGlFaEI2VGU0cVdTWGRMMjQ0LzZGWUg2OTJsc3ZYZ0NK?=
 =?utf-8?B?Q2tQQ2ZIWkp6bUZpQ1RUb1RDdEdPNjljZnZKbXVzZkI3VkhPUzBXTE93WUYx?=
 =?utf-8?B?aTN3Zy9KT0R3UUxxdXJQKy9sT09WTExlUzlRbVpqK1pMdXo5MkZZdzRiSjR6?=
 =?utf-8?B?TnlSK01IOXdlTGlJc0svdzFUbzdqa0JONDVaWHJjUUJhOTN4Qko4QjlHdzFQ?=
 =?utf-8?B?aTR3UXQ0RE9oVEtxNTB4RWNNWmpvYVNybkpCdUdtMitLTUVQWDhmZnVnRkZI?=
 =?utf-8?B?RnM3WHhqQStEY3VCZXN4UnV6WDg1QzlwektnUG9qTC9vcmV0M0xpTThsSnpB?=
 =?utf-8?B?aU56dXhpM2NNeGV3NHVITEN1ZUZ4UlczYXdnZGhBYW9uOFVLOHZoTXU1Q1U0?=
 =?utf-8?B?WWxUc0RpTmVIYUhtV3pCK0hmaG1BYXQ2d0xpd2JKNG1GQ2ptK2RybTBBcm5R?=
 =?utf-8?B?dFVHSTJDbk1ZVmRRV2w2cDVtaExzbVYzaXQvWVl3NDFkYm9BMWVTNVJsUDU0?=
 =?utf-8?B?ZDdnTEsrSS9vRXdSMjhlbWNITXEvaVpXVmJ0M1VOWlZIQS84Zi9ZQkVSMkRs?=
 =?utf-8?B?clNST0kwV3E0WFg4ZU41T3hOa2E0TTVvZE9qU2NEUTNRRTFVWVJFeFgvNXJh?=
 =?utf-8?B?cGJobncxMGtTV3AxRkJTQk1TanNzeG1GdnVJOE0rVzhXUUdNMGphZ29FZGFi?=
 =?utf-8?B?WkQ3Q1pwT1R6NVhPSmFLekU0a0NHcHo2YVQ1c3BvaEMzSDY4bzMyZnRNYWxQ?=
 =?utf-8?B?QWU3SXExYWF5MW5KNTVscWdyTlBYK09XaUhsQS9ZL1VKM1kyeExyWG9VSWdQ?=
 =?utf-8?B?VHBORUVYUFpyQ2U1QUhUM082UDdsZWFqeTZnb0ZTd2h4OTJ5RUNGUEIwM2RT?=
 =?utf-8?B?YlQ5UHlPdXBTYUprU0tlRVNVa1I5cFJ6ZGtiRTF1YXJVeTFhK2J0Rk5tMkZY?=
 =?utf-8?B?ZkxIS2JjNCt0aXJSbGE2MmlYdE9tb1oxM0pxb3dWYkU2OHpNMlRxSlhsbU5R?=
 =?utf-8?B?dHJ2VnNpVlJJeUJQNnhTc3EraW1QVXlGM0JOd2NQbkJaUnJTTDJvaGFOSWkx?=
 =?utf-8?B?djVXY3JmSy9wZUJkY3M2THFJSDJzc0NFa2tOS3hITHJEbkVOaW9IWWdQM0ZZ?=
 =?utf-8?B?RzZpQ0FyaytpM2ZrMHlUWXljQkRaZTQySmw0MUhpOWFranRXUVpLcS9ZZDNi?=
 =?utf-8?B?eWtJWVM2U2lkbThyNXRMSTJOaXpDSkFIeEFKWDVnQ3VGbzg0NWxDRGk3TkRl?=
 =?utf-8?B?QTdBWFZzdmZHekhiblhSaUhtUkJZcFZZV2R5UXo5MjRybnRzblFNcE5wdkpC?=
 =?utf-8?B?MkRBKzRPQnNldlM2TEFrY21tQnZMUDc0MmsvTk1YVzdKNy9VVU9PMXJZL1ZR?=
 =?utf-8?B?cmNyVlV0Y3E3Y2VJL1JXRmRONFg2b2Zqa2RxNXJCWkgzaXM4M29jMjFGT08x?=
 =?utf-8?B?SmY2cElNVC9LSVduQlo3OVE0d3ZpeW9aUUs0dHRSRjdpSWNOTUt5VmNPbjll?=
 =?utf-8?Q?B2t9g+KlVRojxKC+P53m6JdLaRDhP+VaNqd++1xTyuis=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6608.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c1FIWFdBd0k5ZnorbWVzTzR3emQ4cTVFZDhRWHF3RlczVklFdCtmVDloSTVB?=
 =?utf-8?B?SkF1VGswcVhFeUQwR3ZDU0xDQmhPVmxXWXF3NmVsZllHR2tycjM3M3lnNmJE?=
 =?utf-8?B?ZW9xVzFUcjVyVDdqaWU3WUJDUTlNdG9SWEhFS1p6VU1tdUd0THp0RTdkMWpB?=
 =?utf-8?B?RVFuTnNtWC9uS2doQmtZWmgweU80Zm1BV2tiZWx2V2pkK0h4WVRvOXdpdEgw?=
 =?utf-8?B?cy9SMTdWNk80YkVCSDZFaEIrRWV6UFpDeUhOYy9OS2dqaXNTbXNvOEMrTmtp?=
 =?utf-8?B?MGRiMmZRWVBpV1d2cDNOaGxhOWdhLzJiRE5tTityZWZvd2dkODhVRFZ5NmNC?=
 =?utf-8?B?MWlIRlU4ekpobWhTNnd6UnUrWFYwa0xQUFpkVUhQbG9zakNqaFNpbk54ejFO?=
 =?utf-8?B?dnBiSHhGbDlwNUpMbWlSeDAva2RjajhKRHJPODh3Q0xSOW9FR1ZKMVp4Y0Yx?=
 =?utf-8?B?NG5NcWRXd1B5clN2OW0xY2JBdGtMMUFhZm9Lb2M5Q3BKYVl0S3h0Y0pvcE82?=
 =?utf-8?B?aWdXUCthaWZkamZDanpWcU5QUkIrQlJyWXM3UFd6bHIwY29jMTRkTWNkUTdz?=
 =?utf-8?B?VmRHVE1ZRDgra2JPdXpwaUJNTVIvWm1WVDIwdkhzZXpkUEVFSGZqSUtHZTRk?=
 =?utf-8?B?N29BY3YyUUpZTWRYamFDMitTYUdRVVJuZ0ZBWE5sdVo0aDlVMnV0VG1zRTJs?=
 =?utf-8?B?aEFPQVB0Y1lhNTh3VmpQUHpGT2ZKdlh5b1JoUjd4ZllIZWpXSFF6MlRLc1dZ?=
 =?utf-8?B?WjVwR2RzQmN4OWlQakY3bllpOGVnZ2Q4Z3AvRkdqM1U0SVNyb0kzdUZ5TFFw?=
 =?utf-8?B?bGRtTHlkZXpndGJzNitMWW0zeExUYlVhY2c3eEtHQmdRMnZrY0J0UWJtNE1W?=
 =?utf-8?B?UFBkcFp6d1IvQi9OK3lSV2tDeUFmYmpQZVhzdmpHYno1cFY2cVlOQXpUY1FM?=
 =?utf-8?B?dnJ4Mmo1UU1ZVkQ3bUlaT0ozK29OTjBVVkV0TGFJRk9SeENkVHFoem85blA3?=
 =?utf-8?B?QXpyKzJKc2dmMm9WOHVDQXVremtHQ2ZVRFNnVVk0QUZmVy95Ry83b2tZUDV3?=
 =?utf-8?B?cEF6RFBjbzJhWjRaRDJUOHJxWXlzSUc4NEZ2TU1XQ2pDWUl3Zm9USXRQbXZV?=
 =?utf-8?B?RGlheWRvZDNick1kcHd1SVE4aVAxNnBuM01CQVU4cVJJK09RNHF2QS9EKzM0?=
 =?utf-8?B?YmM4djVSLzduVzltaUV1S1l6TjdKMHcvcDVQRkJRWjhlSzRzVUdCNDF2R2tj?=
 =?utf-8?B?K3I3QThLZCtadVkwMDhtTUl2czNlQlQrblloMEd4ZXlxd09vbEx3aVlVbVpa?=
 =?utf-8?B?TWs0OGF3TEZIeVVBaU13K3MxaVFIVXpCUWJkUVpsOEMyRXNzb1hiNTI5aUlK?=
 =?utf-8?B?MjVKUG9mQk1LSUlHajJwWEhwdUVnL2dzMzdGQUZacG4vU0VDbThpQ2ZaclA5?=
 =?utf-8?B?b0xmSjRFYXBjVjM1eVdIMityZ1pYRDM5RmtoMGs2N1NJRUZiN0ZUbHFMZ1Zj?=
 =?utf-8?B?YnlaZEJ4ZWxYL2NQdk83Nkd6RjNoSmNwN3hiWng4NGl3NkpKRGpNdE5oWlR5?=
 =?utf-8?B?TThWa1BTdlB0VTA4Z09UWnM2ditCZG50N3RlWHhyd2loM2xqYXdaNFB4SThm?=
 =?utf-8?B?MUtNeEFlaFlLT1kwZHJsdmRIbVhUeXg0NjlSdlNzN2NaMXMvdGZIRThKbXJC?=
 =?utf-8?B?NUpxN2lsTVoyRSt0NTVDaDZmSlJVWjRzcHRCNVZ3SUNxcGhQKzlpM28xcUo2?=
 =?utf-8?B?d0V0bDkrclY3YmlSTWlZdHNSdmZvYUNLNDRqZEwraHI2NERhWE41UC92WTBT?=
 =?utf-8?B?OEJCbEhFMDlIQU91NkRsVDRZVjlPeWtPRHY4ay84S2JWWlJYWC91NjlVd1k1?=
 =?utf-8?B?eXVpRlhybjFaQUNHbk1hZ1JHdjBLSTZnVzN5K0M4SkFEY21nVXpwbDQ2WmJP?=
 =?utf-8?B?eEg2NXpGUE1MQ25HZ3VBNm9BSFV0eWFHQ1pUcGk0MnRhWDBvcTVOakhFV3dZ?=
 =?utf-8?B?R2NOV04vejZXbUszUWQydkl4SDJnQUNvQzd2WmdDaTlaUVFRV2VaRWhid3oy?=
 =?utf-8?B?KzM2bkJoOW9TbVJVd2trQ3p6T2Q2VnFPL3JMbUI2U2lRWkYwWDZOWmdlT2hJ?=
 =?utf-8?Q?V8IXFm+jCPlkKOHn1PV+VpX4w?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c01ec373-23ff-4a09-2892-08dc805fcb9d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6608.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 04:20:11.0023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W01iKuXo9ZCSYmQ3jxKK9DVKLKIwXKS1DpvwjyF7mLS8bBOG1Y1qVaOSbFDjWon7hR7FKhRYv79uATbGIp85zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7494

Hi John,

Thanks for taking a look at the series!

On 5/29/2024 6:07 AM, John Johansen wrote:
> On 5/28/24 06:29, Mateusz Guzik wrote:
>> On Fri, May 24, 2024 at 11:52 PM John Johansen
>> <john.johansen@canonical.com> wrote:
>>>
>>> On 5/24/24 14:10, Mateusz Guzik wrote:
>>>> On Fri, Mar 8, 2024 at 9:09 PM John Johansen
>>>> <john.johansen@canonical.com> wrote:
>>>>>
>>>>> On 3/2/24 02:23, Mateusz Guzik wrote:
>>>>>> On 2/9/24, John Johansen <john.johansen@canonical.com> wrote:
>>>>>>> On 2/6/24 20:40, Neeraj Upadhyay wrote:
>>>>>>>> Gentle ping.
>>>>>>>>
>>>>>>>> John,
>>>>>>>>
>>>>>>>> Could you please confirm that:
>>>>>>>>
>>>>>>>> a. The AppArmor refcount usage described in the RFC is correct?
>>>>>>>> b. Approach taken to fix the scalability issue is valid/correct?
>>>>>>>>
>>>>>>>
>>>>>>> Hi Neeraj,
>>>>>>>
>>>>>>> I know your patchset has been waiting on review for a long time.
>>>>>>> Unfortunately I have been very, very busy lately. I will try to
>>>>>>> get to it this weekend, but I can't promise that I will be able
>>>>>>> to get the review fully done.
>>>>>>>
>>>>>>
>>>>>> Gentle prod.
>>>>>>
>>>>>> Any chances of this getting reviewed in the foreseeable future? Would
>>>>>> be a real bummer if the patchset fell through the cracks.
>>>>>>
>>>>>
>>>>> yes, sorry I have been unavailable for the last couple of weeks. I am
>>>>> now back, I have a rather large backlog to try catching up on but this
>>>>> is has an entry on the list.
>>>>>
>>>>
>>>> So where do we stand here?
>>>>
>>> sorry I am still trying to dig out of my backlog, I will look at this,
>>> this weekend.
>>>
>>
>> How was the weekend? ;)
>>
> 
> lets say it was busy. Have I looked at this, yes. I am still digesting it.
> I don't have objections to moving towards percpu refcounts, but the overhead
> of a percpu stuct per label is a problem when we have thousands of labels
> on the system. That is to say, this would have to be a config option. We
> moved buffers from kmalloc to percpu to reduce memory overhead to reduce
> contention. The to percpu, to a global pool because the percpu overhead was
> too high for some machines, and then from a global pool to a hybrid scheme
> because of global lock contention. I don't see a way of doing that with the
> label, which means a config would be the next best thing.
> 

For the buffers, what was the percpu overhead roughly? For
thousands of labels, I think, the extra memory overhead roughly would
be in the range of few MBs (need to be profiled though). This extra 
label overhead would be considered high for the machines where percpu
buffer overhead was considered high?

Please correct me here, so you are proposing that we use a kconfig to
use either 'struct percpu_ref' or a 'struct kref' (using a union maybe)
inside the 'struct aa_label' and update the refcount operations accordingly?
If yes, I will work on a patch with this kconfig based selection of
refcounting mode to see how it pans out.

@Mateusz can you share the dynamic switching counter mode patch series please?

In addition, for long term, there is an ongoing work (by Paul, Boqun and myself)
on implementing hazard pointers as a scalable refcounting scheme [1] in kernel,
which would not have memory usage overhead as in percpu refcount. At this point the
API design/implementation is in early prototype stage.


[1] https://docs.google.com/document/d/113WFjGlAW4m72xNbZWHUSE-yU2HIJnWpiXp91ShtgeE/edit?usp=sharing

> Not part of your patch but something to be considered is that the label tree
> needs a rework, its locking needs to move to read side a read side lock less
> scheme, and the plan was to make it also use a linked list such that new
> labels are always queued at the end, allowing dynamically created labels to
> be lazily added to the tree.
> 

Read side would be rcu read lock protected in this scheme?
The linked list would store the dynamically created compound labels?
What is the advantage of using this lazy addition to the tree? We optimize
on the label search, addition/deletion for dynamic labels? The lazy addition
to the tree is done when a label find operation on the list succeeds?

> I see the use of the kworker as problematic as well, especially if we are
> talking using kconfig to switch reference counting modes. I am futzing with
> some ideas, on how to deal with this.
> 

We can disable queuing of label reclaim work for non-percpu case?

> Like I said I am still digesting.
> 

Thank you!


Thanks
Neeraj

