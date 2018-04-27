From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 26 Apr 2018 19:49:59 -0500
Subject: [RFC PATCH v3 1/3] ima: extend clone() with IMA namespace support
In-Reply-To: <0d2b2635-d7fb-d240-7dd0-2a81014c58ba@linux.vnet.ibm.com> (Stefan
	Berger's message of "Thu, 26 Apr 2018 17:18:43 -0400")
References: <1522159038-14175-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1522159038-14175-2-git-send-email-stefanb@linux.vnet.ibm.com>
	<87sh8lcecn.fsf@xmission.com>
	<1523636702.3272.63.camel@linux.vnet.ibm.com>
	<d8c30d7d-c679-9323-7a25-d3148e9b96c6@canonical.com>
	<1524081472.3272.319.camel@linux.vnet.ibm.com>
	<87wox4s282.fsf@xmission.com>
	<8895cb9c-7b9e-2f82-e3d8-a15f5fc26e25@canonical.com>
	<2103bbb9-3f2a-78f8-f7ad-28859659973f@linux.vnet.ibm.com>
	<f84ae8af-fa5b-9f31-fbef-5a49f90dd45a@canonical.com>
	<0d2b2635-d7fb-d240-7dd0-2a81014c58ba@linux.vnet.ibm.com>
Message-ID: <87fu3hbhhk.fsf@xmission.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Stefan Berger <stefanb@linux.vnet.ibm.com> writes:

> On 04/19/2018 11:35 AM, John Johansen wrote:

>> It sounds like its already decided, with ima and selinux going with an unshare file within their own fs.
>>
>> AppArmor went a different route already, splitting namespace creation (mkdir in the apparmorfs policy/namespace dir) and the task entering the namespace with a write apparmor's equiv of setexeccon.
>>
> I am supporting procfs entries for the IMA namespace spawned by writing a
> boolean '1' into IMA's securityfs 'unshare' file. It would allow to use
> setns(fd, 0), obviously with the 0 parameter. I think this is an important
> function to support considering entering a set of namespace. I am just wondering
> about the 0 parameter. We don't have a CLONE flag for it, so there's not other
> way to support it then. Does it matter ?

That should be fine.  We can pick a flag for setns at some point for
IMA.  The setns function uses the flag field as an enumeration so any of
the low 8 bits or a combination with overlapping bit is valid to setns.

Eric

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
