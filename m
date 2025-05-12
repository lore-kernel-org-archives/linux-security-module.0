Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297AB76034;
	Mon, 12 May 2025 21:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747086086; cv=fail; b=R/T8SUVqv0RW8ebXOygzTKVviFa26zwon6FhEmMPOMmeQ+j5WYV29Eljdffb72nQ0qHrbFuRZMA8m3IYegXQzOFH2xorW4tlTbb/Lms7b6rYsmZ0WgDm25HKMY3/5yp7a7pQ2l85o/YVnL4hDM3ADn2n18lkJ0t7mT+br3aZ/Js=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747086086; c=relaxed/simple;
	bh=6FNmU/jMnOaFfsd92zqV2tC9bOObveir1Wp3uPlsShQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UJZZxbZ+xa9V7rVl6C0zbMZxcfrZhZBE99Xux8be5lTbGCiJdj0QjSaHxViIdNAXtKlKaB+zZvnJvAkXvBk7h1cn2QKDAtw5kRhxdQZWVPwOGOzR7KiuWORx+RUXxCT6w2hPuKf9oGmnmisYkvU8fXuuFWI6uDA6AyZLC6Cwl/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QLO7T3b2; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QLO7T3b2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747086085; x=1778622085;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=6FNmU/jMnOaFfsd92zqV2tC9bOObveir1Wp3uPlsShQ=;
  b=QLO7T3b2mvF6uqpMmPlhh+ihMZPuyLQbTXO02t0mrLSFhN73M/PYIImC
   sNUAkYKIO9+PFVKeBKZE81VUoMC1XaODOkpfU0obOHthjECBnSw7rXDgZ
   RJt6x9gdHuQhGPbog3fiiIhGUWOYqCTymYFSdeDah+VHJmlMe9PFTicXc
   TR84HXbTjRrYVtrbG6yqQPGnBW+z5ZaJTszVKmVUaI07c4nOGkNus19Fb
   t9VvFLCAuuYT1VT+i71IxYSjH5soXiWCbH2A+pCOkfWXrUFCn1cyBsY6Y
   uT31Qx70Y2pSWBkx8Mh8uaPbKg+f42hD0kvog1OXBYzHFo1wivd4kNBev
   A==;
X-CSE-ConnectionGUID: RQhaUUUXSmm6ooFsSRfPjA==
X-CSE-MsgGUID: uNnEvwsFT6W0AOOF617CVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="59542185"
X-IronPort-AV: E=Sophos;i="6.15,283,1739865600"; 
   d="scan'208";a="59542185"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 14:41:24 -0700
X-CSE-ConnectionGUID: 16BN6o+NQYSBhsW7tcaztw==
X-CSE-MsgGUID: x3IC+IRBTuSMjjV0p/I/Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,283,1739865600"; 
   d="scan'208";a="174639423"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 14:41:24 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 12 May 2025 14:41:23 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 12 May 2025 14:41:23 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 12 May 2025 14:41:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O6fM03Jf22NTnoVj3KMamb7CmyjACNc4Cw6d4VGA/f2+S78RQLbd8f3W0qjV/BPrvA7/MjrF3VMRqIjGb1lTYuwqXiMiifv2SVivkefiJRBxhgg2g0R0ULDOEi58yB0VwxUnse1zI1hPgCEHRBS0M4aauPT5YI0pcRVhOhfRhtcQfQpBJMUANHc+xgGxE/kmjHn2SvrgHRc7ugTmIMVOOfLHy51yFRu0TZ+JeV72h+bk2BmEkf/bzrIf0Y3LMa8w1QXizjjF1NV5tNqBT6YKSjgfFRw/NmvmXTYUJGAataw8PCeZxsHoWnivO2tol6Erx9gY8SQQ+YeENte9MxK2wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bCy+E+79Fj9UujM+ZFrEtcy+ymEktlFl5HQmqnIM4ww=;
 b=Pu9otDOrGF/sO6/wjtjm9Onx86Zy0TFR25zs5ASHSfFonOlnlIiKLWlhkRNrLv8vkcL86OhK629JwnO39uGvx4nYreEYGZ6LhMLHjOjNqk35bZFVFSosNg1/8a5N+Xjc3jF1kAdL8/5+HXs6XhXvlXUjTxOOSqrcBBbj5qqo0ZO115UOwFZDK+xx/iQxR9EBibjkk7viu4bVS2Rz2WUw0PX6oXNZianjBfK0tmSdRAXBfHW4QL+SCHhnL/jgeEpLt18GwAg6lnVZ/+PNz/kbZrdvKAbt7dX4Gif8k3t8g6I7S0dmIj9j92oJ7Wl8fZ37pR0xEKfjC/fKxsh3Or8gjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB7059.namprd11.prod.outlook.com (2603:10b6:930:51::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Mon, 12 May
 2025 21:40:40 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 21:40:40 +0000
Date: Mon, 12 May 2025 14:40:37 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, Paul Moore <paul@paul-moore.com>,
	Nikolay Borisov <nik.borisov@suse.com>
CC: <linux-security-module@vger.kernel.org>, <serge@hallyn.com>,
	<kees@kernel.org>, <linux-kernel@vger.kernel.org>,
	<kirill.shutemov@linux.intel.com>, <linux-coco@lists.linux.dev>
Subject: Re: [PATCH 0/2] Allow individual features to be locked down
Message-ID: <68226ad551afd_29032945b@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250321102422.640271-1-nik.borisov@suse.com>
 <CAHC9VhSpgzde_xRiu9FApg59w6sR1FUWW-Pf7Ya6XG9eFHwTqQ@mail.gmail.com>
 <67f69600ed221_71fe2946f@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <67f69600ed221_71fe2946f@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: SJ0PR13CA0031.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::6) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB7059:EE_
X-MS-Office365-Filtering-Correlation-Id: c01170dc-56d1-48e6-020f-08dd919da3ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NEtRZnVEemtQMkhJK2lYajk5cVIxdUFLb0U3Z3hSZ1pya3pBTDB4NXVtZTdn?=
 =?utf-8?B?ZmZUSU9QM3JLeWs2ZnpZYkVLZkZvdVc1azVQWnFtTy9aWFhFa09PMUtaZmJk?=
 =?utf-8?B?Qnd5SkZiY3VqK1IzRzJmVkVxVmhQdFNoUnBnRHBqM1l1R2JyellZL016ckF0?=
 =?utf-8?B?RktKc1ZXNGQ4SUszanBUV3BWTjdOMU5pYU9sZmkwcWNyL3lmSjFsaURTTk1L?=
 =?utf-8?B?QTBHeStwc2w1azVzRzhHY1poS1N4NnJKY0hHbGFtM2ZSTGNLU2pSeUp6QS91?=
 =?utf-8?B?QUdzd0pZRzBpN2x2TVh0akoveFhTWFBXZVZ5cS80Q1NvL0NQNVRhUFQwSUgw?=
 =?utf-8?B?M0FHSUFwRXVuZGIwZElzck1tRXhCVGdORWhrd3FYMUpUWlBFamRkR2lCRGlj?=
 =?utf-8?B?a3E0MjFqY2ZYanlGSlNqOG9vRXNjK3RWWGpPNmlSNEIwbzVYR1BiV0V6aDdy?=
 =?utf-8?B?TFQvWU80UlhQanJKczIwSHVuU3VHK1NNcGl4YW0wQTZYQmdtdUQwMHBSQUhD?=
 =?utf-8?B?MnFUQkVzRGFXTm85Z2Z2c0lFbzU0Q1NKZ0FyWmhYb3lCcW4yMzd0SFFFckMz?=
 =?utf-8?B?ZUkyRFF0aWFFVFY1ZVFlbVNuQ0MwR09UOXE3ZVpOOTJmYWxtYjlHdVd0eWo3?=
 =?utf-8?B?QndiYW01VkFEd0ZxTmxKdG1qZWk4UEZibEhJVDlEMDE0SWpiLzkyUTBOY3Ux?=
 =?utf-8?B?U2w1WjZoZlVNaGhWT2VveWlhM2xsSkhvYmpFT2dJZnd1SnhBZXl2bTc0MWd2?=
 =?utf-8?B?VlJqK1l2M1ZhMXJxNjJKSnJPVjM2WFFZaHRFRU5nU1d0cWJheWtNcWxvQ3FK?=
 =?utf-8?B?RXFiVTF2MkZWZkU2VHkrQ04waVNXYndnQVpEN0JWNFFJSnp0aGFMbmo0eDBF?=
 =?utf-8?B?ZjlQR3V5U0JuZzEvZjJGZmhRcnlHVVdrQXF1R2pwRHJzWUh2ZFh6aElOUlJY?=
 =?utf-8?B?OHdvdDVLMU1jeFcwbDZ6MDBHbEoxclpXZHFzQ3dNR3pjR3VybWMxRW5CcmJQ?=
 =?utf-8?B?N000Z0JodmhxTGpXY2JJbUdKaG9tS1FndzFKUG9teUR6UjJ0MmpKSGo3anha?=
 =?utf-8?B?ZG1yS1pQMVJlcEVPNHRSQ0NuSk81WDUvYllrL3U5MDh0a0VMSDNGblArakVy?=
 =?utf-8?B?WFdkZk9FWXhlaXB0cndVaEJpWjZUNmxHREpVQlRzTytwdTNZNmkrd1EzcHhR?=
 =?utf-8?B?N2ZNQk5EUWtSaFlhOXJxY21RZGJBNTZ3OStsM0xKTlE5WWdBS0NIV0NCamhu?=
 =?utf-8?B?R1ZyVkwrNjdwZ1IwSy9XcUsrYU9zVElEYnM3YjRwdFFrZnVqNWlFZkp5YjJW?=
 =?utf-8?B?eTE4UC9HbUtCU0VQY3J0bktuczMxNzB1dTZnODdUanZnUHQ3eDA5bE1mOW9C?=
 =?utf-8?B?L1ZUU25VbnhzcU5VUUMzTnZVWEI2Ry8zWHNNeGxEWFd6NlYvSFQ5UkZCcXJG?=
 =?utf-8?B?NUptVzhMVTVWNUJObldMNzB2WC94QW80NDJ6TWNWTzl4cEVKWk1BczdYWnYw?=
 =?utf-8?B?VnlFWnlqSmFsZDN0YzdYaVZvRnBoZno3Qm9DZDJrenNMdU02QkZRd0lTeTdj?=
 =?utf-8?B?UE1FOWRzZVVNSFd6RkxObWcrSWNMbTVkdXVnWDYwcS9KYk14V0ZHY1h3aVNi?=
 =?utf-8?B?M3hZbXN6dUF2eDVXMDVCU2h3Nm55MmNKbDVsTGxyb1hFRklwTjZmdXFzTWJl?=
 =?utf-8?B?S2pocVdtOWxuUVZKUFR6RzBIL1Y0ZVgwOW5qUDFCdmVpUnc3N09RQXRiOHZt?=
 =?utf-8?B?anZ3KzhjVTZObDRUM1Z1bzRUaHE2anM2WG1lRzIvM2R4UDZaZy96UExUUGNM?=
 =?utf-8?B?WmZOT2RteUE4K29qZlA3YndJQlVMZ3J3dVgvcEl6OVZYdUVqcFRWUUc1UjlJ?=
 =?utf-8?B?Zm9nc3E3c1pBcDJya0thUitKdXNWNFBxTW5XSnRKY1gvMDdkb0REdWdocXBi?=
 =?utf-8?Q?Q/IDxL6rqMI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGtCMVQ0STlTSUNBQ1lydTdLdHV0MjVnc29XUXNnd1JuOXpaZ295a3NMdzY5?=
 =?utf-8?B?YVBPUjZGMUZIencrdVJSeEw2SXljK1VTdEowUWdHNTRkOUFKNFg3WEZmS3lp?=
 =?utf-8?B?SmxGYkRKWTdUakwwQzBNd1M2YUdjZU9jMTA4ODgyaWIycjdrbUxGcTVYQ3JD?=
 =?utf-8?B?dGNFL3NxYzRYMjByQ1hCUnNHR2RCdkNaTkhzSjNnRUdoRDJWQ3hDMW8vdnpE?=
 =?utf-8?B?VitXckFNYkJsUmhJNFBMKy9uRkxweE0xQ2NyUWMrUDI3YUwxOXN5K3JJN04x?=
 =?utf-8?B?UnJFTE5ESUFFSlJFZVhTZy85MnErdVNQNWZRcW51S3lnSFY4Um43VmhvT3lE?=
 =?utf-8?B?QlJKMm9JdWlENDRKUGRMbGJjbXlMeEJybENoMWVGK2RoQm1YQkp6bmdxS1FD?=
 =?utf-8?B?clFBUGoxN24zWStxYWt1Y0lFc1drU1FWN3ZNRG5lNXA5WlhXbXdEMFd6S3BC?=
 =?utf-8?B?OXVkckFvWFMvRnJ0am95a1E1dGgwMm9pdkVzQVU1WVp2MkRBVHlhbTNBTlZw?=
 =?utf-8?B?ZlJHeVhBTW1JMjBEL3kySFkvZXpDYng4aCtFTnQranNldW4vMDlmQkd3Zm1C?=
 =?utf-8?B?S3JGUE01eEw0MFZMeFUxbEdtdjV0bjVBTzB0ZFV1LzFPK0srZmdrUzVSbkU3?=
 =?utf-8?B?TVVYTXdReHhLYzJkVTBYVWh5OFZSWm9PMW1HM3NkZW00eVdTbjNKTHRPZnA3?=
 =?utf-8?B?RVlvalQrL2xzbTZkQUloTkQrT1c2V2ZlN2t6TUZrNmNjRkN3djF3cmJuSVBp?=
 =?utf-8?B?VDg0S3I2Q3Y1Qmlrbm9uRTVNeWo2VDRmNUZaR3RGRkowNDdybTNzdzdlM2ZH?=
 =?utf-8?B?V2owcENGdWZBZEs5UVVDTFdQMWlyQXZjYkhyNFlNd2Zsa2lOcHBsS3JpMGMw?=
 =?utf-8?B?WlFOYkxKRlpJemNUcms0R1hMS042Z3B2UEJvT2puZ2JIb052ZmpZZnIwbkdu?=
 =?utf-8?B?Qk5PVTIwYWpZbmdVTHFjN08xUXAwd3NLQk90RWM5aWhQZnZ4R3BhZ2JjK3RJ?=
 =?utf-8?B?Y3ZoYjM1T2gwL2E5clV4d3I1UHQ0Y2ZjRU9saE01ZWlEZHFaTFQ4MUd3MWhr?=
 =?utf-8?B?eGd3ZEhwKzJ4SDgzWVRxRDRNd0dsUlFESmc5dlhLTHRyU0xNdjhYekNyMjla?=
 =?utf-8?B?K1BQZW54bFJkVmRNQUtCWlJLTFI1RWZWYXo2U3V5Z0o1SnBvMGdiaVBzcVBT?=
 =?utf-8?B?THJEeEdXSHVxQU85TU03bFlDM2xMa1dIU01oaDBnVUpsaFl6SGVaZ0FSWk5p?=
 =?utf-8?B?alR2QUZhb09SNU9PVkdmeDZFdmxJTWYwQ01wOGcwYjJRR1VDem1PSUdhWW82?=
 =?utf-8?B?NGZROVZORWJrNXBlckpYUXJnOFo4UnpLKzhqSThhSStwdnpNVXg1Y1B3cldD?=
 =?utf-8?B?NjJlUnltTkJiN3U3RmppMmZybW1xbm1ORWRHaXBLRGo0aE56aDUrbWZHaU5G?=
 =?utf-8?B?RitYNFZLL01pRThOelcvOWM5ZWVqaGZ1ZXUrYWJ4TGhtcXRoZXkrOUlhLzRn?=
 =?utf-8?B?aEtqZkFYNnZjY0Z0WERUK3psaks2dUVwakE4dHFuOUlBU0FZSGJsYVRnUmFT?=
 =?utf-8?B?dTFIUnQ5OWdiNnMvWi9taE5Ea2s5VzlETzhPc1gzdUp5VXdnS2hsbGZyUFVv?=
 =?utf-8?B?UDlWekRRK1lSWUhOYUtobGo1YkxGdFZBUmNKSEs2bE5lZG85NFp1OWlaRFk4?=
 =?utf-8?B?RmY1enhlbkVWZWJGVzRkM0Fxd1VHUGFkNHpuOGZCLzJ4ZFpvT1pjTWlIRHFX?=
 =?utf-8?B?RVdHdDBOQm1oVmxnMjJtY0lza1dGRkJRbElNd0VZV1RZYmJSTnAzdlBWZG9y?=
 =?utf-8?B?dXloSU1pbzFUY0FnVFd2RHVZb2t4TjE4cEkyamtFdW1hTUJieGxJWlhrYy9B?=
 =?utf-8?B?UW9lbTJlNEhoUFlFNTdLaHZ0bFB2cStjaGZseXhPSUE0RDREbmlVOTFZSUxP?=
 =?utf-8?B?NUV5aEpscFpwcENvcHdVMVUrUm9kci9UUDU3SEhxSWdGWVJkMTdEK3pSOEJa?=
 =?utf-8?B?ckZUOTdBYjRnekdFdDRjYXo2MTdUc0dYZTRlN3ZiQmxvZmY4TnhyZWtEeTJy?=
 =?utf-8?B?eVFHaWVza1hOL3BsQ3UrQmNjZTNEeUlwUnFVTnV0Z0lOcE0rb2xTOHdKckVM?=
 =?utf-8?B?VVFMNU1URmxYUlkvRlRVeVYyMUtsR0RVbXlOSTcySnhaa2tyRGx3Z2NoNHIz?=
 =?utf-8?B?aFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c01170dc-56d1-48e6-020f-08dd919da3ca
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 21:40:40.2963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cBu0er9Vj6SmETnMOs4sGv/iAtEezUffR+isRdJG6GIcd4gD/vTChnUaxa7+QpJ5lfdlsPaeAnaqR4fNfz1tUbX1MbIyNPUPeRXyRUaOVMI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7059
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Paul Moore wrote:
> > On Fri, Mar 21, 2025 at 6:24 AM Nikolay Borisov <nik.borisov@suse.com> wrote:
> > >
> > > This simple change allows usecases where someone might want to  lock only specific
> > > feature at a finer granularity than integrity/confidentiality levels allows.
> > > The first likely user of this is the CoCo subsystem where certain features will be
> > > disabled.
> > >
> > > Nikolay Borisov (2):
> > >   lockdown: Switch implementation to using bitmap
> > >   lockdown/kunit: Introduce kunit tests
> > 
> > Hi Nikolay,
> > 
> > Thanks for the patches!  With the merge window opening in a few days,
> > it is too late to consider this for the upcoming merge window so
> > realistically this patchset is two weeks out and I'm hopeful we'll
> > have a dedicated Lockdown maintainer by then so I'm going to defer the
> > ultimate decision on acceptance to them.
> 
> The patches in this thread proposed to selectively disable /dev/mem
> independent of all the other lockdown mitigations. That goal can be
> achieved with more precision with this proposed patch:
> 
> http://lore.kernel.org/67f5b75c37143_71fe2949b@dwillia2-xfh.jf.intel.com.notmuch

Just wanted to circle back here and repair the damage I caused to the
momentum of this "lockdown feature bitmap" proposal. It turns out that
devmem maintainers are not looking to add yet more arch-specific hacks
[1].

    "Restricting /dev/mem further is a good idea, but it would be nice
     if that could be done without adding yet another special case."

security_locked_down() is already plumbed into all the places that
confidential VMs may need to manage userspace access to confidential /
private memory.

I considered registering a new "coco-LSM" to hook
security_locked_down(), but that immediately raises the next question of
how does userspace discover what is currently locked_down. So just teach
the native lockdown LSM how to be more fine-grained rather than
complicate the situation with a new LSM.

[1]: http://lore.kernel.org/0bdb1876-0cb3-4632-910b-2dc191902e3e@app.fastmail.com
