Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE66825EF83;
	Wed,  9 Apr 2025 15:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744213518; cv=fail; b=LmPZaC1mqax0yFJ9U2U1xcB/HwJwNDz+z1vO0tankvKh87i/RxG2FRXLnwlRc/8T+SYWEC8mK95Dx+fn5KISvkR2Etg/L91ZQznFC3W0viBNm+tDZB6oCqHmCnktxt+kE989rgy9N+41Js/O30vjKZGvS7KbbJAiwYF9AiKn/mA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744213518; c=relaxed/simple;
	bh=rL/fjA+lPCggJ4GHZCfuCa7eH8Pwe/UoH2nD1mLLTWM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Nfr7Xby09RJZHYcyT+Pkghh9Z7kRG+PvvpJ7YWQL4XLr8XHVvZippbdIpG3tNhUf1NWaA3bF2DCOWfY54p6Bff3r+2VsGspoxqXU6RiHoJ+ed5jdfIPPJPJhxHPbqOX+F5ypTxsTszaCrqlUmzuf8wTUvnVB90JheW3K0sIdiOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WJdyVoTz; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WJdyVoTz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744213517; x=1775749517;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=rL/fjA+lPCggJ4GHZCfuCa7eH8Pwe/UoH2nD1mLLTWM=;
  b=WJdyVoTz6BUOjLWeOSfOEMZ3I1wOaO7K11Ctjf4LJ5eTp+PLdOaT98JR
   /U8q1ZJpl5axQVEhdTElANyNvk6Hu9VjFKMO1F/0yBXpeATLt/VKxYd8H
   sj5MbkBvXxpfqvrwGOcOcRAYLeasz3rg4p54XtgZylo4Frk7A3VzOVLFl
   Iu2YFZ2kNYcQauriRFmsSsHJYjd84rKoJqW212kzh4sZX5hZ9tfxfIo9/
   QzJ8B8hXjfP24gaIska5PaOCcjZpm3S96mcuLHHsKAT4i89Eq7X3TwnmC
   PXIJhQjCOelL35ZIEg0V7Gak81eYqj+bDbT0cn3/kNNcatoBNUGoh0xi7
   g==;
X-CSE-ConnectionGUID: oHaCVhN1R8Kmf/N5uMxvUA==
X-CSE-MsgGUID: NkPQNXJeR1CYMmvD3YjBbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="49492052"
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="49492052"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 08:45:12 -0700
X-CSE-ConnectionGUID: cp+isuoyQlCHG3tXKvmZwg==
X-CSE-MsgGUID: OCf2LDbOQJe/nXij9gZDoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="133341589"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 08:45:11 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 9 Apr 2025 08:45:11 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 9 Apr 2025 08:45:11 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 9 Apr 2025 08:45:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dYFkAVXUfpXu9KS84hFGVHWdCZPUaQljDSHIACkUhax2oRCMPQcS91YuwV9ZdHUpY1xc7llRN7YkB17C2IbvrTQ7VNU4cT3Xi6aIgD9sXXeRvXBvOvpAFSnwvAPoGcO2N4vQg5dLVVo4ytaT9Fx9ALZCknfVEt0qR7KTx1VPkbsfyCWpbgKpqgwCtbwIshT39nIWmVxswZKzjvf0cIkAUmq1OcexD5Ni+iRvvcYfdPbe6V6Vbcg51IiP8nUkug3RHg0dBDVv4ma6yFa5B/LVNmbVPDkzdrXaaIiNfVOQz3cT9XE5T6K6mOVY4OD0O3HBm4K4+vdskxgqKESlk7uAJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ixen9JL4jtsv35WxEeZHmrUdOg5kGI6UYfcUHFnjspg=;
 b=Ix6SWyASlFKvXttDJG3g0ZUdkI6E34mbuNIagaSjii1WqCxkuAI69Z4v+D3kvuIA8t1LPIcHqlETX1ObIn8sueADkhKOzdvJttrXKd/aZSOKBSOGBSwSNvp3TjxTyX04tDCODsmJOQKUee3bvziD0LTpy3M/vrvhJ3qjrFGf7UKSKu6F28Suw8zWxsuqyz/q6hU1N8TKtiY7xoTAggsOSc+hpgkXeG5lXRrW+fz/X2inzt7Nz2aU8+yUWcKhgpFPaMoo2yrlg/jIrBe1XcWbSLGxBfPsABP1sotOu2QBOLTxeIegfHK0IsSvErtTVOMzEQxYKToTofpfsr54ykLY1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS4PPF382351574.namprd11.prod.outlook.com (2603:10b6:f:fc02::1d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Wed, 9 Apr
 2025 15:45:08 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%3]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 15:45:08 +0000
Date: Wed, 9 Apr 2025 08:45:05 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Paul Moore <paul@paul-moore.com>, Nikolay Borisov <nik.borisov@suse.com>
CC: <linux-security-module@vger.kernel.org>, <serge@hallyn.com>,
	<kees@kernel.org>, <linux-kernel@vger.kernel.org>,
	<kirill.shutemov@linux.intel.com>, <linux-coco@lists.linux.dev>
Subject: Re: [PATCH 0/2] Allow individual features to be locked down
Message-ID: <67f69600ed221_71fe2946f@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250321102422.640271-1-nik.borisov@suse.com>
 <CAHC9VhSpgzde_xRiu9FApg59w6sR1FUWW-Pf7Ya6XG9eFHwTqQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhSpgzde_xRiu9FApg59w6sR1FUWW-Pf7Ya6XG9eFHwTqQ@mail.gmail.com>
X-ClientProxiedBy: MW4PR04CA0084.namprd04.prod.outlook.com
 (2603:10b6:303:6b::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS4PPF382351574:EE_
X-MS-Office365-Filtering-Correlation-Id: fc264b70-9439-4759-7881-08dd777d8149
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SkszYjJndTNxTFF3Z20zSHRQc3FwN2FJSjlTL3U0OHdNLzBnVm1Tdk9pTDZW?=
 =?utf-8?B?RzR1YkRuMkF0dmUrTFR3ZTd6RzU5SXd4T2QzRW41c3VBUmNGVHJ2L2c5dU1C?=
 =?utf-8?B?Q25pdnVxWHJUN1QyVUI0dXBpNzdoOVQySzg3RG9hMVlOV1lKR3ZDR1NxTzly?=
 =?utf-8?B?QU4xWnprODhTbTJIcnQ4U1lhZUJKdGQ5VW0vMjhMbEdZZ1dvUXowd2NuYldW?=
 =?utf-8?B?azByVlI3OXFVZTFpT3UyQXpmc25GTW1iTFNEd2tIYWsxNGhKOXgvQlVKQmFG?=
 =?utf-8?B?OUxmbnk3RXdGbXpBWEZYU3pESHZBMU9GYVhGNVZQdXVTR2ovc0xnc3lLUENl?=
 =?utf-8?B?cVNQalVYaWRhYUcwK2JVVWg2RFRUKy9XVGRQQ0xEbUluSjU5UTQ1MDNZNThv?=
 =?utf-8?B?dFA4dVFXdTNMMmxabUwxMDRvblIvaHE0UjZSZWhlMkxPNVZSQ1dyTnBFUmdJ?=
 =?utf-8?B?UFZIZ1lNWHdBeDIxbHI5cDM4R3lRTVhoaEYwWU12ek02OEhvNXBGc3hvS2Rs?=
 =?utf-8?B?Q0s5V3BXSkdrT1VNK0FMakNUNFVURGo0a0pNcjZkMlJ3aTVlOHZpV05SWGJV?=
 =?utf-8?B?SWQ3RFdYaXlwWkxNNlcxMXRxbyt1WE0vaElJMGtKZ1F0SENkUE9MVGFwVEQ1?=
 =?utf-8?B?QXowVUMvTEs1d1IvdjZQaDZzd052WFRvODFSYkNsWlNBR29pUjVNZWFaUGVZ?=
 =?utf-8?B?bzR6aElRZ24wd0VaSXdtc2tyV0VuRWNlKzJvN1VqWFIzSzJieFVJNVc4a0RJ?=
 =?utf-8?B?bFB6RXdlcUsvWnIzWkxESkM4ODNrbjhUWWpmRlFaWncxMGFvbXdrUFR5ZEM2?=
 =?utf-8?B?NExQaGpwU3RGSFlycGJRZSsvZkNaNmxnZFd2UUlzekl0L3JaNnNRQTRpZlNa?=
 =?utf-8?B?eVN4R2JJSzFxWTRVcmlTaE1GYjhPUFBJd3NuQ2N5Vzk1ZDlLUkRSZ0xiTjF5?=
 =?utf-8?B?YU1rWXJxaGEzVjFPNmpwT2RVUGJOL3k3Kzd4OUZ5ZjZiNGJYRFZTTXJ3cGZs?=
 =?utf-8?B?THMyTmI2TWJFanNMUTNMYm9Oa3Buak5kR1dNV1NvT2NxS0J6N1ZXVEpsNmJF?=
 =?utf-8?B?b2pPODJCek9CTVJyOCtWNUp5K3E0TmF5bDVxTkMvbW5samw4ZnE2NkFDTm5C?=
 =?utf-8?B?OCsvbnA3c3BRaXJvNTZIZnNqWUVNQUd1UC9PYmliM1VybWFrZkZpRE9ULzN5?=
 =?utf-8?B?WE05SzhKRm5KSlFHd01iWHduclhhMkxhTE5ra0RjTEtOVlNKMlJjOWpxRENM?=
 =?utf-8?B?WU1nUHQxcmIwNTl2eVpKa29ibjFjSHYzT2ZTeHlVOXBUUzNRRGZJY1ZZOVdH?=
 =?utf-8?B?MDJrNFdsRlBiV3JNNmJVV1pYdWRTc2FwNjROVFozSC9adWhEZ242UU92ZWM1?=
 =?utf-8?B?K21wdm9pTnpvMjVyMCtBSzJ6T0VDUTBpWStERHlsUEFPektjLzF5RytrR0tQ?=
 =?utf-8?B?azNORGNOMmZ1STVBY0xLYTF3emQ0aWFjczBHb0tjUVNUYWYxR01VVmZjTGRs?=
 =?utf-8?B?ZkVuUWJaVUFoRnhrRnphYTRqazJDZnRObGtFZFhrWXFKQjR5SjNROFFvWFZq?=
 =?utf-8?B?aEtiUmVXWHBLVk1JNnAyQS9aOXVkS3J1QnRRLzhCaStCSGlKbWUvdHJDR0hw?=
 =?utf-8?B?a2Y4N0hRYy9qcFRDNklibWpHSTBQWE5OSHNVTFc4cHBHemFQQkptRjdvdFNq?=
 =?utf-8?B?Zk1GVHgzbEd2ZCthZkU3Nk5iTWc1QU84RkxSZ3FUWU1ITm9uUHp0cEhuNkhz?=
 =?utf-8?B?NG1ERnZWdkJRbU5DTjNRaTR4Q2NpWm1yS1ZHakFlS01uYWdtd0tVcE9JSVVa?=
 =?utf-8?B?b1dxYTRGWGpXem5WWnR6UmhPZGhyeWw4OVE3MDExYWxVUHI1d0VlZ05SNXlW?=
 =?utf-8?B?bDZQR2VGVVVMY3ZRNjdybGR1djQ0MEpncDJBQWZvY1J0YjVxamxMQ0dZTVha?=
 =?utf-8?Q?0Jx1DGfTsx4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHlMM1FzZnA0YStrVFRnRzM1MFBTYjFNYkp0WW9CeDBRUUZVTzdTS3l5alBs?=
 =?utf-8?B?Y0piblBISFcwNGVRL0xsc3BhOU1wVkF3d2hzUlkzSFpvUHRJREM1cnRFdGZy?=
 =?utf-8?B?RzZyazB6N21TWXUrNVBuQkdUTnJNby9IaGsyOFJjZFdlWGRKSGRqV0JucHdD?=
 =?utf-8?B?bU9NY1AzcVdOcXQxendGSzRMVVdzY3VLbEZWVXQwS1YzSC9vSnBRY2Z5ZjNq?=
 =?utf-8?B?djMvYUNlakJ4RjFDUEt6Tkx1S1diaVFqdCtpRDBpaUxVRGtEN3c2dWdhMzly?=
 =?utf-8?B?SExwbThkZkxaMFJvdUx1eXU2RWJWRWxGL0JhWk80R2NDcVRHamVYV09INUM2?=
 =?utf-8?B?aDdpaU9WWWJndmJRS2g2WUorbkhNUGF5a1QrQ25WNEl3N2FDNElLd1FTNXRR?=
 =?utf-8?B?aWdCNW50R09rZ3Z5NFJ3b2w0dHRvcXhqR0FaNlZRSFBRdDBkTHBBMUF5QlJV?=
 =?utf-8?B?SGwzbXZ1MjREZ1lOMmZFbVhhcU9TSUdIV1BpQWRHd0pFNlVjSkRNTmdYVUpD?=
 =?utf-8?B?S3M4RmJsdHZYREkxd0ZtRG44NGNLRjZEc2RtbkhGQW13L2FJNDZBU0FTRW9y?=
 =?utf-8?B?dTc2S3NwMjVPWHBjbWFkNGpGVXJFNUw3WkQvaUpDbU9oa0RHa0dBS3FYM0dK?=
 =?utf-8?B?T1ZzUHd3OWgrRElFenJjUTA4WERQN0g4UEttSzB3Q21HeXloM1laUDY1Mldy?=
 =?utf-8?B?MXdkZFRaSG9oU0ZwYkkxQTU5ZDhQWUNPenpkYVRpZmxqS3lxZmZXOWtOZU1K?=
 =?utf-8?B?UEpIVkMxR0dvNnU0U0xtN2w0di9RTEZlcVU3eGJJb09EbURuZ0YxQ2tVcDJP?=
 =?utf-8?B?d3lGTkNUeGtRQXU3dWZRdkJVd3FmZlBmTjZ1R0lmRjFnTnJqdTE3VnZVVFAx?=
 =?utf-8?B?VGVkMVphTHVaeVRidTJmelB5ZWg5Uk5VelorTklFa1RZVzlaUEJKS1phakhj?=
 =?utf-8?B?TWdEMzlocks3MTVRb2w5ZlFObTlBVFlMZjRwRm1TbkJkNTRtUFNDTWFUR0FJ?=
 =?utf-8?B?ZVkxU0Qydk11ZkVrd1UweDUxRjJBeHVJTjJDUllMTUl4Uk9ZV3ZJU1k1R3RB?=
 =?utf-8?B?YjAvZkEvbE5McGFHV2wvSEtPMW9TV0hmWS9YY3VQaHFPZG1uV1A0YVNYeEVw?=
 =?utf-8?B?OGI3ZFJtZERpdkdtNTNzeGNjcmlIUVdoek5wNFlrRmVOTFQxNE51aGNOb09K?=
 =?utf-8?B?bW9Ld29JanhDOXVKMzd4VVU2dnhxdkFXUXh5M1B6eWZGNVRtbGsrMXlMWC9z?=
 =?utf-8?B?VWlzTncrZ2YrOXdjVWh1TzF3ZWlnVi9TbU5zZFYvRndGRFMyU2xnYVJ4NzJL?=
 =?utf-8?B?alBKODNhUDl3c3F4RWpBYWF5ME9zOWlTY0J6OUFvOGJnemphcVRwZ2VyRVJF?=
 =?utf-8?B?U0hicEt5ODB5UXFMaC9GRXhsU3lEL2hEWlg2eDQ3THljYStmSnhTUU9NQnFi?=
 =?utf-8?B?NVgzVU9TVmR5SjQrVWZyRVhEanFUMnlBYnVhNS9Wek5zWTZYWU1DNGxKeU11?=
 =?utf-8?B?bjlzWUl4aVpQZDRPUFEvL0M5UlExR3RoMWVJSzIva0xQT2NXcE5Talo4a1hV?=
 =?utf-8?B?a0JoalM0U1ZvYjFnNHZDUUlIWUp6emZhRjh1eWpkcWVWRFZFMFo0WVRHVHZJ?=
 =?utf-8?B?QVpJejZVWlFlV0NyQUwvL2lLMmRwT2p3ejN6VFFOSHJ1RmhLTXVXM0FERHh5?=
 =?utf-8?B?RmM4MkdpQkxZSEpzbmpxRVNBZ0g2U2t4cEZIbEdkbktkMmVFVFFldTd2ZXlx?=
 =?utf-8?B?WEtldlZZbklPQkpUWUVUV0E5b0dQYmJUQTEwUzRiM1N6TW9iWnN4VE0zNEI3?=
 =?utf-8?B?RVIxa3VCSW9Ybmw4Q1pSTnc2OXFOcThjLzZ6cGIySGd2cy9tdDV0S29QRVQy?=
 =?utf-8?B?d2FKRFZvWi84VnZuYzhYdFA2MTJ2Y2VWbWhvcnUvMXhMZ3JSOVhsTGdxNDg2?=
 =?utf-8?B?Sm9NV1hibjdUSXEzWWwzMXV5amk2YTE0YTFuOHFseGVrcVNHaFRSaWd3cjkw?=
 =?utf-8?B?clpOczl5a0Y0MkVlQUJSTkZDMitpaG8yTlJSaXdIbFBWbFk3ODBDRGdjUnc0?=
 =?utf-8?B?YXN1dHVOYWtReEJrK2VLNmRUKy8xRnhCcEVKd3RWSUNZenJzSFY3RGZ3YnMx?=
 =?utf-8?B?NVpLbDJiMDE1aVM2WVZSNEFKY2RsNEZMOUk1d1NKUVMyaDQ3Wm9PamRISFlJ?=
 =?utf-8?B?WFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fc264b70-9439-4759-7881-08dd777d8149
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 15:45:08.2331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2wM6NylYxEyKtm6eDFl6TbKB1AXKlGXGhCZPf3gqxWLSCaHIM2SvHgeB7notnQfQvx8/i2vN5VAZV/nbdOseTQo8fI+8qRKnhN6IaI/+4w4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF382351574
X-OriginatorOrg: intel.com

Paul Moore wrote:
> On Fri, Mar 21, 2025 at 6:24 AM Nikolay Borisov <nik.borisov@suse.com> wrote:
> >
> > This simple change allows usecases where someone might want to  lock only specific
> > feature at a finer granularity than integrity/confidentiality levels allows.
> > The first likely user of this is the CoCo subsystem where certain features will be
> > disabled.
> >
> > Nikolay Borisov (2):
> >   lockdown: Switch implementation to using bitmap
> >   lockdown/kunit: Introduce kunit tests
> 
> Hi Nikolay,
> 
> Thanks for the patches!  With the merge window opening in a few days,
> it is too late to consider this for the upcoming merge window so
> realistically this patchset is two weeks out and I'm hopeful we'll
> have a dedicated Lockdown maintainer by then so I'm going to defer the
> ultimate decision on acceptance to them.

The patches in this thread proposed to selectively disable /dev/mem
independent of all the other lockdown mitigations. That goal can be
achieved with more precision with this proposed patch:

http://lore.kernel.org/67f5b75c37143_71fe2949b@dwillia2-xfh.jf.intel.com.notmuch
