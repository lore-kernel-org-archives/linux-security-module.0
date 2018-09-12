From: casey@schaufler-ca.com (Casey Schaufler)
Date: Tue, 11 Sep 2018 17:01:21 -0700
Subject: [PATCH 01/10] procfs: add smack subdir to attrs
In-Reply-To: <20180911234538.GB12337@darwi-kernel>
References: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com>
	<c43599b8-20f6-0cc6-28d7-abff4c0d0a0d@schaufler-ca.com>
	<20180911234538.GB12337@darwi-kernel>
Message-ID: <cb61a8bc-eb36-3eb9-88ab-d30c6522619b@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 9/11/2018 4:45 PM, Ahmed S. Darwish wrote:
> On Tue, Sep 11, 2018 at 09:41:32AM -0700, Casey Schaufler wrote:
>> Back in 2007 I made what turned out to be a rather serious
>> mistake in the implementation of the Smack security module.
>> The SELinux module used an interface in /proc to manipulate
>> the security context on processes. Rather than use a similar
>> interface, I used the same interface. The AppArmor team did
>> likewise. Now /proc/.../attr/current will tell you the
>> security "context" of the process, but it will be different
>> depending on the security module you're using.
>>
>> This patch provides a subdirectory in /proc/.../attr for
>> Smack. Smack user space can use the "current" file in
>> this subdirectory and never have to worry about getting
>> SELinux attributes by mistake. Programs that use the
>> old interface will continue to work (or fail, as the case
>> may be) as before.
>>
> Did downstream distributions already merge the stacking patches on
> their own?

Ubuntu is leading the way with adopting the stacking patches.
