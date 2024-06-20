Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2064.outbound.protection.outlook.com [40.107.212.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7351BE222;
	Thu, 20 Jun 2024 18:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718907811; cv=fail; b=lYv5xBNo13aXEqr5xb5POJOAbIgSYExR0/jw5+QEcuGTpxiZftoh5qMj931+xYMCLZBO/73S5p7Che23poERDsYsL0iuYpTK4a9x5MGj8H4b6AgTfCK3jJQlp17XXBNjOnwr7xPZ/5lPjDB4rEWJrv1Ty47FnVGKpY27dPNnLf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718907811; c=relaxed/simple;
	bh=xZqkx5bHb+k85CYwZA/BBw5L9iuDczY3uBtQkWWpgO0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LB+06/Df7HQ++lYOyYSlKCqFigw5agJHsbUN7km6ARY5SN+QPsRwDvKQsfizg/AHWqCg+X5gXct6mQ++DCOZc+Vrz7kD0qGT0c9Vfau3+5vgLLBpJ0n8p/6xL7nOEm0PHaYNBDPSH61R6sp3bBcCE1+znEd9//TiYD/4u6rpIhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2+mNm9VR; arc=fail smtp.client-ip=40.107.212.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2+mNm9VR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hlDfUHTX1tKtajITn1l1ogNxljURd76bxnbxI7hQkHuqDXLwj2Qq9VAXVSXr7sThzaPq++OV4pPl9KxxAHaPqCvUitHY+f/fGeVa4RCG4ZhBkIhieDBcbl8f07OqB/hqqyceuTSGrLghjo2mjGDWUPCKguz1AG9+vtw/8EDPqAaLDa8M6j8KBXL2KNy54TLTfl/tnzMH4u03e9jTmlS3DrQ1J8C3WxAvTpDuGqkiLL8PxGVshrPznCwEaOkPWTP0cf9Bmkg3FloS+7FP1L0kVseBj6tE/7oTzWj4ETyYr+194xFVSt/PFYq0XKFvMGIqErTM7FYpdrCj9zu+qBqy0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oHaGzMGlEm8EXV1PRWNycoyS5nMh4vD9Y3n05cv4LhI=;
 b=lsvSNpxJ2q7TpodBvYliurmlKjW1E9zpGFuRW4AJPicO1MSaG+DiODN6vxaU7JX3m/MNq4N16CSVate9JiS6DjYTRwe/l4rTrH07nbHb6JDK2FxV7z6Rho7tK3TjAEEJeUVqKG0l5SvjYB3QCsiuaYlk8DeoREvsKMMegLdg+woS8CNA1j9afGr8XCtutoZR6X4YbxxNM/0ynnsUoAme9DyKaS2ey4QyfLKoer3sI1UtiKDqA2sw6Zdw4nSU4MEE1OVDWoZbODhhyX0DFd+2+eiEMTtslrGODCt1UX15b2GFY3AMqMW73+yeb9h2ajK+4yB8aZ7bn0cWYfthaSyomw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHaGzMGlEm8EXV1PRWNycoyS5nMh4vD9Y3n05cv4LhI=;
 b=2+mNm9VRHyrDR3uFjPPi9zs/U46LUHmK+ygKctNuJ4MqeBBMCDzqzQNzXPsDNXvTGriauY4x9R0jrFqM1I99V6aoceFo8rHvBo+pmfRqedCh8U/NsE/ZybHLo9D4Aoa/LIRA2kAeV5sU1INU/fHtYKLaiT505cKgXGlIkHfqANM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) by
 MW3PR12MB4348.namprd12.prod.outlook.com (2603:10b6:303:5f::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.21; Thu, 20 Jun 2024 18:23:21 +0000
Received: from DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627]) by DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627%5]) with mapi id 15.20.7677.030; Thu, 20 Jun 2024
 18:23:21 +0000
Message-ID: <155a24f7-8059-49b0-93fa-94bcdc058621@amd.com>
Date: Thu, 20 Jun 2024 23:53:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] apparmor: try to avoid refing the label in
 apparmor_file_open
Content-Language: en-US
To: Mateusz Guzik <mjguzik@gmail.com>, john.johansen@canonical.com
Cc: paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
 linux-kernel@vger.kernel.org, apparmor@lists.ubuntu.com,
 linux-security-module@vger.kernel.org
References: <20240620171528.167997-1-mjguzik@gmail.com>
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
In-Reply-To: <20240620171528.167997-1-mjguzik@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0054.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::29) To DS0PR12MB6608.namprd12.prod.outlook.com
 (2603:10b6:8:d0::10)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6608:EE_|MW3PR12MB4348:EE_
X-MS-Office365-Filtering-Correlation-Id: d63eb344-7416-4a2e-c8c2-08dc91561081
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|1800799021|376011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dFJCcm9mOUI1VEU5cnJaZVBMTjZyVVRHSDIvY3pHYWVoWTRRL09RWGJKTzY0?=
 =?utf-8?B?dmx4VVpLQUljQXNIa3hRcHJ1QUY2Um44Y05YV2x0bVNtN0UxQXhBVGY2SWxZ?=
 =?utf-8?B?dmF4SWJwQjR5aCs2OE5Cam5PS2F4clJtZFR0N3E2YWxJRERQdW5TMWtUTjlC?=
 =?utf-8?B?cFl3KzlUTU5KV2xETVp0ckZnQVFheEs2Njc1b3dqTmxmOVZhMGN3R3pOWUxL?=
 =?utf-8?B?KzdXMVlBN2IyMFNTZWZkN0JWcVArZVRqa2dyL2Y1MWZib3BUQ2h5a0lneWky?=
 =?utf-8?B?dnhDeTFtVnVXVi85cTY0MDZ1bGVjYlE2WkU0YndqRDk2aU9WUHJMazRZWkdE?=
 =?utf-8?B?ODBTTUVHd1RXWlR3TGhvc1Q1Z2lLdlpPVzVqbERMVTdZOGZxZFRERHI5dDdH?=
 =?utf-8?B?SWNBNDkwRzA1bXBOZXQrL2VuYU9JSzN4SjJvbFh6YjVwYlF6Tzg3d2JpVkxZ?=
 =?utf-8?B?QjZDMUtPM3VKU0w4MS9QcXZ3SlpYSzZuaHdSV0w2RzFVdWl0cTB3cXdBc0dv?=
 =?utf-8?B?a291QWIzNlhKdjBSZVB0Qkl1azNDT0cvNXM5MnJsRTdKTWprYzRqY3BSTlZB?=
 =?utf-8?B?Nm1NTFdWRmtiOGkvbVFXSDhsVFFSRjdLRU9FNTN3L29ibmJqbkRaOTZpV2Zv?=
 =?utf-8?B?dTZuaE5tNCsvMWpMemIzT0ZZdHJPVzM5bVB1K2V4bDZLUmhib0xoMjEyeEpQ?=
 =?utf-8?B?SUczS2RkUi95eXpsM0Zha2IyNGZvb2U0dCt3dnIvbnF1aCtHTXVaNGEvcFo0?=
 =?utf-8?B?R21lVVhydlByY3lKNGhFTTVwdGRnTU0xTUc5ZTFqRVRobWlsc1JoK0pid05z?=
 =?utf-8?B?alFzVGRtbW8wN2NyNkpOQ0s5QnFHZnNMRzJPeW1ibk85OU9lcmtWL3lvMXli?=
 =?utf-8?B?Y3E0MlZwSktTNEMzMmZCeGVhSWNjblpZV291cTQrTHJHQjJ3ZlRwUTVrc0ZT?=
 =?utf-8?B?SUZYd0grcVZrMVJwbU5HSmxEYlk0cC9Xak5ZcmpkNFRNcVV2dy9CZXlGYXc0?=
 =?utf-8?B?REkwSVQrWjBObm5WcDhGNEZta00zeklaOEtpZFZPdW1VTGxDYUROTUxXT2xt?=
 =?utf-8?B?UktpaTlNTzZYUEhqUXRxS3J2WW1JVnZOMG1PcUt0SzU5RDJKRVkyOVhVOVB6?=
 =?utf-8?B?ZFdUNkhFMnZNdkdkSlVvT2lJMER2VE53UjFyQ1kvMG5zNitFKzM4ZU1ZOHh0?=
 =?utf-8?B?dFZ3bkEwV2hmY2hDREJnYlkwTnRBMnh6bmVmTlpnMnBlRXVQL3d5OWxJYzVS?=
 =?utf-8?B?WEJNaWZBZW1WeTlqbWltaVJ6UVRKaUtMc3FXNy9BYi9pOWU5WnRLYWl4dGo5?=
 =?utf-8?B?dVhjb3h1VzgzT0Frc3drQkZJdkpBVmF2RFFpcEhYa1FjaEE1cjB4WHdYbGJs?=
 =?utf-8?B?Z1FnbnJQbzlLUHNDdjlvZXJ6NXh4bmxVa04xS2ErNUsyQ1BZSDFGbGR0a09a?=
 =?utf-8?B?UkpqajFHU3Y1eTl2NkcwRFB5bDBGMU5NYm4wWXVjdVBlbC9CRCtuWThSRjhR?=
 =?utf-8?B?Tk4vUkxSNnFveUlQd3E4Q2FCbjVFUU9mZFJEaGR6OGlZRjdlWlVZUHJYV2s2?=
 =?utf-8?B?ODFOVWxmbmM1dDdtaHpHc0JTTjZiZ3k4aEZZTkQwdmp0K083eTFOUExyM1VC?=
 =?utf-8?B?S3VBUlVqTm5hQ1d6aHNuQ2lzNWhjajVISnVTOUhQKzNwOVNhWFpuUnZwUEtV?=
 =?utf-8?Q?qyJN0IKJXQ1AXwEQoi2N?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6608.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(1800799021)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bU02R21KMjJMMUJvOE5KZzZtUnBqdXlHUzF2Q0NOYWRla3kxZWIrdFROUTF0?=
 =?utf-8?B?VVJKNU11NTJkajh0N0Zob1ZCdnVyTGdObSsrdjdGbkluZXBnU2szU2pNK1BI?=
 =?utf-8?B?YnFyTlRTM1dpcmVTR1YvaFpacCs4SGRkK25TaE1xUGNqSndZSUJDRUViRWZT?=
 =?utf-8?B?ekFPN2l5bkJiSWVSa3dEM3U4UThHbklNVlRjNUZaUlRueFlyMlZoc1F3TWFI?=
 =?utf-8?B?UGZ5WnE4VFRnNkJOMlUyYnRsSGhZTWlhKzUydENOc1YzSWJGRTBNdjBBVXQ4?=
 =?utf-8?B?dnlYTkhkMHFmZWZoNzhOUEtXdm5uVkRpNi9kOGlwTXBlYkdCUHhveHdKU2Iw?=
 =?utf-8?B?OWlRWGhsTXdpS3lHdkxIUy85ZFBnUU9EalFkOXRYM1lWSlEybWhzMFczdnpk?=
 =?utf-8?B?NXdzeWtSOGZlemxQdS9iUkh4eVI5QXNMMFcxcHA0ZUxKWEhuYkxmbUVOVlYr?=
 =?utf-8?B?d3BpT0FLemhXTTdBaW5iQlVsbFlCZlhFVnNvT3RxMWhib2tSbHJJbGh2T1lT?=
 =?utf-8?B?RFpiRmtCQ1JpKzdnZGo5a2plbyt1dkE2OWRGRFZnL3RTMFg2SlY4RzVZdzlj?=
 =?utf-8?B?Qk9WZm9JTnFmTUFGcWZGcms3UGhMYkFmZ1ZjV0lYQ0RQMVNKMDVCMmRVWHZO?=
 =?utf-8?B?MHdEVVdCdlVwUWxXWWs3RGxJK3B6MkVNZmFsT0xDZG1iT0dqUEpDbFJQZ1Y2?=
 =?utf-8?B?NDk3cDNNNDVjNUFWbDhnc2FncEFqYzkxM1VOR3A3K016aWhjd2ZROXV6KzFC?=
 =?utf-8?B?T0FnNERlSmYwZUIyNnErTm9NVGJrbXBPNXVKRzJ2bjE2WVhZZ2FXUTBtSFE5?=
 =?utf-8?B?eVErVWJYWDVBN2VEL1E5OEo5bUNLSHJ6VjQ3UDl1LzhJT0NsOS9CS1piYm5k?=
 =?utf-8?B?R1RMNVVuQ2tQVXJnUEI5VTN6cVdGVVZqRk9RNEloMVBXb0VIWkRtZzR1RHVP?=
 =?utf-8?B?cENEcVlRdnFTb29hYXVxL3pySUl2RlZBRjQ1OGR2TjNyZ1BpbVBibi9NTG9i?=
 =?utf-8?B?dlBlV1UwbDR4YkxUNTlQZDlURUR1SzVXaWJVTG9yV01YRFlLeCtkUWJZZ042?=
 =?utf-8?B?WjZlS3JsYi85UDFuSWVDZFNEcjBqK1dqem52L3FBWkZTL0ZiV1hqZ1NvLzQx?=
 =?utf-8?B?SXBkZUI2bWdsMUNTaVBQK2xrWVZzL0FLY2QxeHlaZzlPbUVtbDZzcmZySTNJ?=
 =?utf-8?B?bS8yUWh6d2UyMXJRWXdrZ0htcWtNbk0rSlZtcHRONkRuL3p1VlNDZkNXSisy?=
 =?utf-8?B?dkh6ODVlSlBSaVJJZklSYjMzN2JabllqRnVVbHpqM3ZRYWFCcW1ieGZJME5Z?=
 =?utf-8?B?bVRjWGlmQVBLL0ZsU3VhTHpaUU9BU0F2eVQ4cGJPaDR2emJDaU5JRWplVTNF?=
 =?utf-8?B?aXl3UytaTnBTd1BXYnBnSXU2VnVEWHNmOHJlZmpjakZiRVYzc05uajNnS1Vq?=
 =?utf-8?B?VXIvMXpEcEZEVTB5YmVMdkRYcjA1Y00wcWE1dXIvWHN0VmVQc3N0aTA3akFt?=
 =?utf-8?B?dU9scVlldjBIdG9EQ0NoaHpQYWcxWGMreVJBM3NDQktMeWE2M0pLV2sxVnRi?=
 =?utf-8?B?V1AzWXFBN3IvdjQwUFBwZUxlTWdXczZaeEJyUUtDWkRmMC85KzJlWHc1Y2wx?=
 =?utf-8?B?RzRlUWI5VXRqRnJWV2dZVmsvaEJLM09EY2NzWXVmZU9lVFczdmIxU3FXQkxh?=
 =?utf-8?B?SnU2azlGSFc1UnVRNklwMDZRRFVLeXlKc3Nld3hxbGJaekV5V2lKL0o3ME43?=
 =?utf-8?B?SmNoWHUwazErd0drZkRYdk9VeWJzclQ2dEZsV3FiZXV6SWpVRzgwNmlCN0tq?=
 =?utf-8?B?a2RnN3hLaGpUNTZCdXRNSlRKRDNrYUlzSVp1ekJCN0tkWkhwdENEUERQMGJL?=
 =?utf-8?B?M3lMU05oK09sQXBvUDNYSkZwSnEwK0dENlRuTFFUb2ZwNkw5SWNxYU9aQ2c4?=
 =?utf-8?B?K29TT0VRVUlER1AxQUpCVXpRb0pDR2lNZmlFSzd2UXRLWXNnVnNjZG1BOWRq?=
 =?utf-8?B?NmJ5a0JMd0s0NGx5M2Z4aHI3Z1gxemlmUndEOXYxUUN6cFpXQkR6NFBWdHlI?=
 =?utf-8?B?TTNlc2hTRHloWGd6V1UzY3ZMb1JUTGEvVE0ycExJK2V1dG5PeE9DK0IvTmlY?=
 =?utf-8?Q?QR2qsmGEzWcOYkOCjM6PQ5jKz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d63eb344-7416-4a2e-c8c2-08dc91561081
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6608.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 18:23:21.3854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YBryP4vLURMMugWXJD6EHyKOt8emDi/o7jG6PV4Sl6cwRQvYf0qvARAaGYyYmJJBlvW6HfM6AmS5/qMiJN5jMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4348



On 6/20/2024 10:45 PM, Mateusz Guzik wrote:
> apparmor: try to avoid refing the label in apparmor_file_open
> 
> If the label is not stale (which is the common case), the fact that the
> passed file object holds a reference can be leverged to avoid the

Minor: Typo 'leveraged'

> ref/unref cycle. Doing so reduces performance impact of apparmor on
> parallel open() invocations.
> 
> When benchmarking on a 24-core vm using will-it-scale's open1_process
> ("Separate file open"), the results are (ops/s):
> before: 6092196
> after:  8309726 (+36%)
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---


Trying to understand the changes done here. So, while the file cred can be updated
async to the task (referring to the comment from John here [1]), the file cred label
cannot change during apparmor_file_open() execution?


Reviewed-by: Neeraj upadhyay <Neeraj.Upadhyay@amd.com>


Thanks
Neeraj

[1] https://lore.kernel.org/lkml/9bfaeec2-535d-4401-8244-7560f660a065@canonical.com/


> 
> v2:
> - reword the commit message
> 
> If you want any changes made to it can you just do them on your own
> accord? :) Will be faster for both of us than another mail trip.
> 
>  security/apparmor/include/cred.h | 20 ++++++++++++++++++++
>  security/apparmor/lsm.c          |  5 +++--
>  2 files changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/security/apparmor/include/cred.h b/security/apparmor/include/cred.h
> index 58fdc72af664..7265d2f81dd5 100644
> --- a/security/apparmor/include/cred.h
> +++ b/security/apparmor/include/cred.h
> @@ -63,6 +63,26 @@ static inline struct aa_label *aa_get_newest_cred_label(const struct cred *cred)
>  	return aa_get_newest_label(aa_cred_raw_label(cred));
>  }
>  
> +static inline struct aa_label *aa_get_newest_cred_label_condref(const struct cred *cred,
> +								bool *needput)
> +{
> +	struct aa_label *l = aa_cred_raw_label(cred);
> +
> +	if (unlikely(label_is_stale(l))) {
> +		*needput = true;
> +		return aa_get_newest_label(l);
> +	}
> +
> +	*needput = false;
> +	return l;
> +}
> +
> +static inline void aa_put_label_condref(struct aa_label *l, bool needput)
> +{
> +	if (unlikely(needput))
> +		aa_put_label(l);
> +}
> +
>  /**
>   * aa_current_raw_label - find the current tasks confining label
>   *
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index 2cea34657a47..4bf87eac4a56 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -461,6 +461,7 @@ static int apparmor_file_open(struct file *file)
>  	struct aa_file_ctx *fctx = file_ctx(file);
>  	struct aa_label *label;
>  	int error = 0;
> +	bool needput;
>  
>  	if (!path_mediated_fs(file->f_path.dentry))
>  		return 0;
> @@ -477,7 +478,7 @@ static int apparmor_file_open(struct file *file)
>  		return 0;
>  	}
>  
> -	label = aa_get_newest_cred_label(file->f_cred);
> +	label = aa_get_newest_cred_label_condref(file->f_cred, &needput);
>  	if (!unconfined(label)) {
>  		struct mnt_idmap *idmap = file_mnt_idmap(file);
>  		struct inode *inode = file_inode(file);
> @@ -494,7 +495,7 @@ static int apparmor_file_open(struct file *file)
>  		/* todo cache full allowed permissions set and state */
>  		fctx->allow = aa_map_file_to_perms(file);
>  	}
> -	aa_put_label(label);
> +	aa_put_label_condref(label, needput);
>  
>  	return error;
>  }
