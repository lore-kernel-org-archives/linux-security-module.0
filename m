From: casey@schaufler-ca.com (Casey Schaufler)
Date: Thu, 27 Sep 2018 15:32:15 -0700
Subject: [PATCH v4 04/19] SELinux: Remove cred security blob poisoning
In-Reply-To: <alpine.LRH.2.21.1809280813270.8410@namei.org>
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
	<5360cd42-5827-58af-515c-6e1ded1d9154@schaufler-ca.com>
	<alpine.LRH.2.21.1809280813270.8410@namei.org>
Message-ID: <84719272-fb62-76b6-b2fd-f0c36d49707d@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 9/27/2018 3:13 PM, James Morris wrote:
> On Fri, 21 Sep 2018, Casey Schaufler wrote:
>
>> The SELinux specific credential poisioning only makes sense
>> if SELinux is managing the credentials. As the intent of this
>> patch set is to move the blob management out of the modules
>> and into the infrastructure, the SELinux specific code has
>> to go. The poisioning could be introduced into the infrastructure
>> at some later date.
> If it's useful, it should be incorporated into core LSM, otherwise that's 
> a regression for SELinux

When I discussed this code with David Howells he indicated
that it was primarily used for debugging the original shared
credential implementation and that is was not especially
valuable any longer. If someone thinks it is valuable we
should consider doing it in the infrastructure for all the
blobs, not just the credential.
