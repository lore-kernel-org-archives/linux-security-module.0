From: dave.hansen@intel.com (Dave Hansen)
Date: Mon, 10 Sep 2018 11:57:49 -0700
Subject: [RFC 09/12] mm: Restrict memory encryption to anonymous VMA's
In-Reply-To: <ae0288d5205a5c431e9a6bf0c9e68beded45e84b.camel@intel.com>
References: <cover.1536356108.git.alison.schofield@intel.com>
	<f69e3d4f96504185054d951c7c85075ebf63e47a.1536356108.git.alison.schofield@intel.com>
	<ae0288d5205a5c431e9a6bf0c9e68beded45e84b.camel@intel.com>
Message-ID: <84154fd2-7c27-0fd2-f339-15e144a5df49@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 09/10/2018 11:21 AM, Sakkinen, Jarkko wrote:
>> +/*
>> + * Encrypted mprotect is only supported on anonymous mappings.
>> + * All VMA's in the requested range must be anonymous. If this
>> + * test fails on any single VMA, the entire mprotect request fails.
>> + */
> kdoc

kdoc what?  You want this comment in kdoc format?  Why?
