From: casey@schaufler-ca.com (Casey Schaufler)
Date: Sat, 11 Nov 2017 12:18:36 -0800
Subject: [PATCH 0/9] LSM: Stacking for major security modules - Based on
	4.14-rc2
In-Reply-To: <CAHC9VhQ+BBoxz7cTnTc46hQ88LnLM72fNA9zhDbWn8XUoVS1NQ@mail.gmail.com>
References: <1473402e-a714-7ace-2698-b65d73e3f17e@schaufler-ca.com>
	<CAHC9VhQ+BBoxz7cTnTc46hQ88LnLM72fNA9zhDbWn8XUoVS1NQ@mail.gmail.com>
Message-ID: <4748f521-2794-80b7-b9bc-20b50571f89c@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 11/11/2017 7:48 AM, Paul Moore wrote:
> On Fri, Oct 27, 2017 at 5:34 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>> Subject: [PATCH 0/9] LSM: Stacking for major security modules - Based on 4.14-rc2
>>
>> This patch set implements stacking for "major" security modules.
> ..
>
>> I have tested these patches in various configurations of Ubuntu and
>> Fedora. Smack and SELinux together pass test suites with some exceptions.
>> There are conflicts with the way the modules treat network configurations.
>> These conflicts are under investigation, and changes to Smack (and
>> possibly SELinux) to reconcile the worst of the issues are in development.
> This remains my big concern, especially the network support.  We've
> talked about this a lot in person, but until I see the code which
> deals with this I can't ack/nack this patchset.

That's well understood, and appreciated.

The LSM infrastructure is based on the system (e.g. vfs) code
making calls to hooks when it is time to make a check. The netlabel
system is based on the LSM making a call when it has information
to present. The former makes coordination of multiple security
modules relatively straight forward. The later requires holding on
to data until such time as the end networking code needs it. Even
if all the security modules made netlabel calls from exactly the
same hooks (they don't) there's still no place to pull everything
together. The solutions used to address the security_blah interfaces
don't work with the networking implementation.

I'm on what I think is about my 5th approach to the netlabel problem.
I have discovered all sorts of nasty little issues, some of which are
artifacts of the IP stack, and some of which are the result of more
general memory and object management.

I would be delighted if someone where inclined to point out an
elegant way to approach the problem. Lacking that, I'll just keep
plugging away with my 12 pound hammer and rusty crowbar.

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
