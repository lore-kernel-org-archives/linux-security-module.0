Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222DF165F16;
	Tue,  5 Aug 2025 23:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754436499; cv=fail; b=meVXLukyWzDZdOIbaDDng5lascfdN4IbDvxhbRza/zQMEb/4hGeI3rKiX2+gZkEWb9vgOMKGRg3ZRQ1q3uLGaYOf7MhHTCzTEW0vUPa8Oyog2YK7Eqf2L2P+522XJC5M62LYFOAzBLrMMV2Xb7HuWO8IbFbd/cjcm0T0L4ICkRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754436499; c=relaxed/simple;
	bh=CY84z56wd7Vma54laU9Jsd6JQZDpJFWApsRXm1+L8UQ=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=IFjbxLWEKFUlbHz9m5e/c9KQwcEmj6ZsmKSfKB0wTPCu80TPIlZ/oRKGkR//i8PyP2Sam0+7EG24wGRkYlQYEtFX0GpjL5qGxxDwFbZ7AIO01ufF5FfmPrlxZcEakDS0Wjkurzx/UjcS3a5Euzxfnil/7TxEYpHrRvWoJAXaytc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dfce4IV3; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dfce4IV3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754436498; x=1785972498;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=CY84z56wd7Vma54laU9Jsd6JQZDpJFWApsRXm1+L8UQ=;
  b=dfce4IV3GBDKXBwZ/B2fpjwAMzzxwsyPPIY61IYo4L5oL7rL6bCi3xV4
   u7yn6NSnzYJXXNRJhRYS+u8f08q4oXP9GV9SrO88tNjXIV9OwWNNPXTDQ
   n6tEU4h91fTBn64fe2MvZ+fGcQfUi157L9odXeRXYg0B2xt1oir3l9lX/
   2gc1NRj2B2g3vtknaAN02ybhnnZPoUbi1L7RbpOQIHA49BqFkJjQv1xBk
   eTPoaCO8s6d2EoLn8Cq+I/+J+0vSWvr1nR2CEnGPA9G//DcjEC9qAl6U7
   N/oI/4lAQfwZthYnIjX7g9hjbG6Wv6ykX64nhgg2xZ5MDhMkn/j3v+mQZ
   g==;
X-CSE-ConnectionGUID: qY0eZpsDQcW4GeKN0MQ6og==
X-CSE-MsgGUID: ApU5dhqQT+WXtqXHehSBmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11513"; a="60559010"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="60559010"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 16:28:17 -0700
X-CSE-ConnectionGUID: lnE1uJlwQ0O+aVYUSNp3mA==
X-CSE-MsgGUID: sKmRCXT3QYqO6gROs3HHlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="169999644"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 16:28:17 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 5 Aug 2025 16:28:16 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 5 Aug 2025 16:28:16 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.49)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 5 Aug 2025 16:28:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WkUYNm41RY1LY60mHSBOfnWaE74UIMdKXznGVHJUJS5zHMprq+f3H6KuvhloJTpbsDaaZ/aOI8DXUgKwhl7ZDJsEsYlkoRTEzeNBAPOJJsWCiNAxFWcK5Zomw30hVMMUcf2CZrzAtTjEETNLsJgYRv2WDrOj6AwZHxFW8XerVioE0mLm79uBkHjvKxR+1istuld5m5Lh+L6m/GKpWB+NIM1Khl2Hm9tzRrExL7chzE4anKHsGHevHoizr/OetESXjLRZqTlF5e0dhXYJJ3NNYCDa5+RLbuyM7z0lVQHqshWq2OMndJl326FTsBkLEZYv+rZp0qveDPJ7lt0Z6Sh9yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CY84z56wd7Vma54laU9Jsd6JQZDpJFWApsRXm1+L8UQ=;
 b=LtyNswEOg/TAyPoKwWkoUuqANyLz3HKeke0FaCuwvfSxlXhq+tlLjqscc64O0TOX2kRmC3mCNVWTl1ALP2AeiAnr2Hl7W3jPFouutGjqJsEtC7XT9IjZSY9Z1S/LYoG/a6utUxyGTP6NfR6VyM8UZONkzrG6xpioWAogic4SjQok7sk2caTrnwmKzlgMvRosouanwIP8Pi2+rJd/xjJsyk+jliwrGwMl71J0qKmV16FRDtEHzvMbSwp6fpDhpLnEJuH3NaTe88EtQCU1xh5iJtEFAzaQuQxiIRdayYOGRdT5yTS6t10QMBT0xtPSf46PopKYbBBtXjxqmV3aVulVkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB8563.namprd11.prod.outlook.com (2603:10b6:610:1af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Tue, 5 Aug
 2025 23:28:14 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9009.013; Tue, 5 Aug 2025
 23:28:13 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 5 Aug 2025 16:28:10 -0700
To: xiujianfeng <xiujianfeng@huawei.com>, Nikolay Borisov
	<nik.borisov@suse.com>, Nicolas Bouchinet
	<nicolas.bouchinet@oss.cyber.gouv.fr>
CC: <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<paul@paul-moore.com>, <serge@hallyn.com>, <jmorris@namei.org>,
	<dan.j.williams@intel.com>
Message-ID: <6892938a78e77_184e1f10067@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <42b2cf1b-417e-1594-d525-f4c84f7405b0@huawei.com>
References: <20250728111517.134116-1-nik.borisov@suse.com>
 <kl4rvgnupxnz4zrwlofrawdfy23tj2ylp5s3wovnsjxkr6tbrt@x5s3avqo2e7t>
 <9b6fd06e-5438-4539-821c-6f3d5fa6b7d1@suse.com>
 <42b2cf1b-417e-1594-d525-f4c84f7405b0@huawei.com>
Subject: Re: [PATCH v2 0/3] Allow individual features to be locked down
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR03CA0191.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB8563:EE_
X-MS-Office365-Filtering-Correlation-Id: fcdc05b9-bd8f-46c0-1584-08ddd477bf05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NDJTbWY3WTJYWk94aTdGNUJ3citMMXNkdllwcDBDbVNORENPU1VJNHBiZ096?=
 =?utf-8?B?WExQZHl5VzNaZS81RWlBa21SMEtRVHNwbnQ4R0JtUzlMWHdNelhRMWNIL1dN?=
 =?utf-8?B?QXRLZTJtM3FoVzJBM0c3bzlpT2c5U1g1b01oNTZNMndMSFAxeDJjMklXczk4?=
 =?utf-8?B?MG9sT1NrYitmZ3JkVEQwa2lrL2MxYXNZM2EwQUJZb1hMeGtmeStWY1pycktT?=
 =?utf-8?B?ektXRmN4L0tNNm01aFRrZDZnNGdKeWxCYjhxNTlyYm9LQ2duVVgzcWkvc09y?=
 =?utf-8?B?WjJUZjhYM3RJODdubS9sR1loYmlTWVI5TlNWRFhseHdtRStOT1VoZXk3MlRQ?=
 =?utf-8?B?S3Ewd1JucFVQSzJGckdWOEg4M3g0Q01reXEzUG1INTg4cXFNa2dzOVk5cGpi?=
 =?utf-8?B?STk4RnV1ZTBEemd5Q1ZRMTlVS1pXNExRVzBlVHBxcGh5dEowR2JtQW45ZjZ3?=
 =?utf-8?B?STkrNGtWRWl0Sy9ibWkzbkFWQ1JmazlqdWNwNVZENzBzRjBGLzJOQ1FTWGpO?=
 =?utf-8?B?eFgyQnVQSGNUMDB2dVNCd1FJdDdxVFBFWFRCR05DeWN5SndwOHJTZ0VIS2NG?=
 =?utf-8?B?ckNpQjEybnRaZW9iRzRpb0FWS2dod3U3K1I2Z3hTdi9lY2FLMjJiQXdPU04w?=
 =?utf-8?B?OGZLclp6eHNKckJoVE5lL0hFRyt0eVVNVWRXSkt0K2lrNlJRbHdjekJqK0hV?=
 =?utf-8?B?UU4wUWZ2WmlRUkVoOFZ4OVhBNyswR3Vad3pYVTJma0hJeFBTSXZCc0szWEFB?=
 =?utf-8?B?OGJIdWRSd3hPMVZaZXh0YWlOUE1ETzZKeFRnQjJpTm1pWUtLWkVpQWN0aGQv?=
 =?utf-8?B?V2JVTDh2c1JQZFB5YTY4V1JlUXMwMWhZQ0VmTDJVM1Awb0F3VEJXZWV2NjRh?=
 =?utf-8?B?aWZ1Wjl6a2ZjakZvZWxjd1Z5WkhZdVBYV1N6TDRXMC9xMUM2OWJvREwrN2tH?=
 =?utf-8?B?ZnJ3NnpiRE5TaFNpUUNlSmlSMkN5S1FpWGNRVHkvZDU0WnVMZmhGVUlraGVN?=
 =?utf-8?B?VEVDbFQ5NlFpdGxhczNpT3hGZW9LaWJVcmxPcGpaL2F6QXFCa25HeSs3VzdZ?=
 =?utf-8?B?alVwanlNdFRQVjRuY09ONE9vOEt4Y3FaMjh2YVdUclkyUzB1RTFaWUc5dTlN?=
 =?utf-8?B?NTBpWGV6ZVJOemZqUzdYelhlVWlLR3pwOXlWYk52am9RWWNXUzV0VisvdTlh?=
 =?utf-8?B?RTRadnloQ3RWWmxuT21YaXZ1dU1oYzJrUjUreEt2OVhxOUtkbnJHNzFVamxS?=
 =?utf-8?B?ejRHWVVUL1pwYi80U21paUwwemw1V04wQ04wWTREcXAwa2RyYkxVaE5vY014?=
 =?utf-8?B?bTBjaVJqdWRCOEs5WW8wWUVCRkZJQTljd2MxV3Qxd2tPL0VpcUd0QjE5b1c3?=
 =?utf-8?B?eUZUUFRZVEFTUVpVRVBvY2UyczVFYURSVjJqOEFTN2Jzc2F2NmJnQUlvRGJN?=
 =?utf-8?B?bUVEU3YzbTZlWmdqVDhMMTRaczZERnM4L0dvOXdydEpiY09wa0pKbXlUMEVF?=
 =?utf-8?B?Y1RQbTBnc0Q4aEIwdnhFdTNRTjBxa0hHb3laRFJEZzlQNHR6Rm1hYWdHMDJR?=
 =?utf-8?B?djg3enJMRjdGaGUwS3pNbUZNdkVRbktqNkU0aUpPOG5OSko5QWRhT2pPUHg0?=
 =?utf-8?B?OFZwWU43R0dXbzdwSjV6b1V3c0VxQXFFNmc5cVRndW1NZUY0elR0NGJ4b1Rq?=
 =?utf-8?B?ZXFHeW1hZG9RSXl1dUcvUS9tQ0F4UERlNmR3ellIait5YkJzV2VTRFMyekV0?=
 =?utf-8?B?VmVjZndHanBiWWZkbS95cjBmWTVEbFRwT1NSTmY0K2RITzQ1M2Jhc0R3NDNS?=
 =?utf-8?B?a0NYQmhkZFZFd2c4Mit5NFYzcmlqMzQ0b1JTRm5TTTI0aDlVaGVPOElTdGk0?=
 =?utf-8?B?Z0NnOSthRlQzNlBObmFvaVZYamhhRmg0elRqa3diVEwvYlBkcXU5MElJYUlo?=
 =?utf-8?Q?QaCnC3g6hbc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFo1ZmZtUUNYTFZleUhucTRFbUxUNGdINUNLMHVadGtXOUMrbWV1Ujd6OUcz?=
 =?utf-8?B?MDdTK0FlR3RkTlRQYndXR1l4QzFwYVUzL3FRNHJpR1JGUE55Y0E2Szh0MVpX?=
 =?utf-8?B?NmgvSm5CNHZCNEEwTXl1QXJBVksxZkVUUzBjMDNPRjZYR21NKzh2amtER1FI?=
 =?utf-8?B?WTI5WC9aWHZpM3EwbFY2WldCZ0pXQ3JhU1VEY1d2Nk1hNWxuWS8wekZBVjIx?=
 =?utf-8?B?NUxVT3BPcnR4TVhjeU10aUdIRnMySXVOS2xPSEEwbjVUbFhGeTRJNUlLbjVC?=
 =?utf-8?B?Z29mNWdhKzRnU2NPL3hGL2g5b1A0UEhaZWNMVWNFUHNFNlNGWWprWTdhb2V1?=
 =?utf-8?B?UG4vMU14alRIcUdBemxWT2VBMDhzTWVDNnBROVBWZUgrSytYYTQvYWJSZnlv?=
 =?utf-8?B?Rm9WZzM5dkt3NmluRDZCWnA1Z1BURU1GVFNqMm80U0xxL3MxUXpOQjJrdnJH?=
 =?utf-8?B?b3JxMUVTelFMcm5yQjZ1OThDMUFoWGFabmRNZVkyNlFsUHk5K25mYlV3L3FH?=
 =?utf-8?B?anlyM1IzK3M0RVhjc3VLR2lJTTNNK3ZUWllKZmJGMElvMkN5SW9qNGp5czdp?=
 =?utf-8?B?bis5Z3RPNDkvT3hSM0E1OGxLa1VOenFGV3o0a1h5WUtMbUROVVFHa2wvRmdp?=
 =?utf-8?B?RzZ0M3ZDWlBZaWxSVmp5QkNQQVpZZE95TFRZT2lJTk5ydDl5NUNMMWNzTzNY?=
 =?utf-8?B?SDRlcDVaMVhvcWpSTHpBcEV4MjVCd1FpWndaU2tZemZ3UUtXdUlUUjRiTzBC?=
 =?utf-8?B?NWt2WDIyQS8rcG1BcXgzc2gvWm9leWFsNE42VXVVeUVHVElrV3o1a1pJbFZp?=
 =?utf-8?B?NTduYk1pSzNtemZTeWdvdzhxd3V2bk40UkU5YUtncEVWM0g2czQ2Mlg2Ylh3?=
 =?utf-8?B?MitSTWRFUlFiTUNGM1ZsaE1zMzdpZlBFY0lFcm11VkkrOXpKUnpCU25pRFRk?=
 =?utf-8?B?Z2hjODcySjN5KzhhcnloeHJvTDIyNllQcUJhVnFBaEJTVWRYTzljcTNaNlRT?=
 =?utf-8?B?UTUzOUowWm9YaldCZE9XS3FTRCtacVZGZzlUNFBhUGo4YUZPUkFUT3NDZnhR?=
 =?utf-8?B?L2N0cmVlenJQSG9vbEdWSnE0ZlpPaFQ2UFJ6ZnYvL1lvc3U2ZnZnYllLREZh?=
 =?utf-8?B?TytCL2R3YnNxL2ppT2tZeVdpdFY1bUhyd0pPZy8zdkZNZmFzRVFNYjFtelBo?=
 =?utf-8?B?YUd3OCtkT3ZCKys2bmkvTVljcll3eElUWWpyRHJCY2h5dndHRWtBVTlpVFNx?=
 =?utf-8?B?cjBxbWtQNjRFK3ArcEExRWVQYk40OXFUS21odHh5eGpHT2RjTytOQURyTFFY?=
 =?utf-8?B?eU5TZnJsSmpNNWZPNkJjemt4OWhLUVBhQ2MzNzYzOExmQ2NqR0M0WjVoRHlw?=
 =?utf-8?B?d2pKaGk2MnZmRTlvMm5mMnJsUlRMWmZyekNxMG0wQWxjdlFvaTN3elhBc1pq?=
 =?utf-8?B?WmU2UElqOVZFMlBnQ2dnNlJIdmRwYmlYUFpaWHpENU5UMGxROTd1cEVRNFU4?=
 =?utf-8?B?Q2UvdUl6S1B3MzZid3RGYklReWdCUjBydGhDRzFqQUJjUE02QzVmd2FGbHY1?=
 =?utf-8?B?eE9CVUNZS0FxSG9nK1luWFhkandYcFg1UjlEQXBGR3BnM3BTY1Y4ZlFtUE02?=
 =?utf-8?B?SW1Jb2VzRHRpSjBiTkRJdHBvTGwycDJLYjNhZVdaSzJQbm1LOUtoWlhKZ0Vy?=
 =?utf-8?B?dGdTOWlJNVZwS0JVZ3Z1L2tLS0ZIVmJZdkVuU01zdStzbTNCK2oyQ0tteUJO?=
 =?utf-8?B?VUh3djkvdWlvdHFsQTlqRTBPU21jci93N3dHcE96SHIxZ3pjLzBkeGlCU3NT?=
 =?utf-8?B?ZVM0MHVzc1gvS1dFejBYOWtVZXg4K3Z6YWQ5RXY1K0ZYaWNiWXF4RzJRZHRo?=
 =?utf-8?B?QzRCWmJXME1rR255YnI3cTZDbVRubU1hV0RIdjRFcmVDRkszbW4xeStWOVdT?=
 =?utf-8?B?YWhQZnBiSnFneXhYeTNhTCt0SUs0c1hUbE95eUZMeDZ5alNTa1dwZkgrWXV1?=
 =?utf-8?B?OWMrOUp2NEwxditXTGUraU0zK0VxTW91VkJ5Sml1a204MmRjVnZZa3g2M0tz?=
 =?utf-8?B?c0tqcGs3U2FqNXc5ZEkwZU9ZcTJzQzBkc1B2aUV3SmNtNEFMVWt0cDRlUUpk?=
 =?utf-8?B?aWNta3ZwaVZ2WmJDMlVNblExaGZzUW9pWmlTRWs3V3lkOUE3Sm9jRUxEQmxS?=
 =?utf-8?B?eFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fcdc05b9-bd8f-46c0-1584-08ddd477bf05
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 23:28:13.7347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fEecymgNnZFquq8TGKSLIceS/Dgv7G0UsZcZQV6cyWaUduPeVEnhxMBC66o3KXNMjsdT0LhWwink6v1YEFrM7sMebEu32Z1Nwu+WsqDxzOc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8563
X-OriginatorOrg: intel.com

xiujianfeng wrote:
>=20
>=20
> On 2025/7/29 20:25, Nikolay Borisov wrote:
> >=20
> >=20
> > On 29.07.25 =D0=B3. 15:16 =D1=87., Nicolas Bouchinet wrote:
> >> Hi Nikolay,
> >>
> >> Thanks for you patch.
> >>
> >> Quoting Kees [1], Lockdown is "about creating a bright line between
> >> uid-0 and ring-0".
> >>
> >> Having a bitmap enabled Lockdown would mean that Lockdown reasons coul=
d
> >> be activated independently. I fear this would lead to a false sense of
> >> security, locking one reason alone often permits Lockdown restrictions
> >> bypass. i.e enforcing kernel module signature verification but not
> >> blocking accesses to `/dev/{k,}mem` or authorizing gkdb which can be
> >> used to disable the module signature enforcement.
> >>
> >> If one wants to restrict accesses to `/dev/mem`,
> >> `security_locked_down(LOCKDOWN_DEV_MEM)` should be sufficient.
> >>
> >> My understanding of your problem is that this locks too much for your
> >> usecase and you want to restrict reasons of Lockdown independently in
> >> case it has not been enabled in "integrity" mode by default ?
> >>
> >> Can you elaborate more on the usecases for COCO ?
> >=20
> > Initially this patchset was supposed to allow us selectively disable
> > /dev/iomem access in a CoCo context [0]. As evident from Dan's initial
> > response that point pretty much became moot as the issue was fixed in a
> > different way. However, later [1] he came back and said that actually
> > this patch could be useful in a similar context. So This v2 is
> > essentially following up on that.
>=20
> Hi Nikolay,
>=20
> I share a similar view with Nicolas, namely that using a bitmap
> implementation would compromise the goal of Lockdown.
>=20
> After reading the threads below, I understand you aim is to block user
> access to /dev/mem, but without having Lockdown integrity mode enabled
> to block other reasons, right? How about using BPF LSM? It seems it
> could address your requirements.

BPF LSM does not seem suitable for the main concern which is that arch
code needs hard guarantess that certain code paths are disabled. For
Confidential Computing it needs to know that userspace access of
/dev/mem is always disabled.

This is a functional concern, not a security concern. Both Arnd [1] and
Greg [2] lamented needing new hacks to achieve the same outcome as just
reusing the existing security_locked_down() checks. The
SECURITY_LOCKDOWN_LSM already has /sys/kernel/security/lockdown ABI for
communicating built-in and now kernel-internal sources of locked
functionality.

[1]: http://lore.kernel.org/0bdb1876-0cb3-4632-910b-2dc191902e3e@app.fastma=
il.com
[2]: http://lore.kernel.org/2025043025-cathouse-headlamp-7bde@gregkh=
