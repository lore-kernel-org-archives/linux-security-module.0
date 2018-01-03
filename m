From: casey@schaufler-ca.com (Casey Schaufler)
Date: Wed, 3 Jan 2018 11:32:38 -0800
Subject: [PATCH V4 2/3] IMA: Use consistent creds
In-Reply-To: <CACdnJuv7ADizvK8omRJA244N65ReYqWT2HSS_T=_uV66wMZ6Sg@mail.gmail.com>
References: <20180103012017.7022-1-mjg59@google.com>
	<20180103012017.7022-2-mjg59@google.com>
	<cd89f3cf-b620-b098-a3db-c53f05d330bf@schaufler-ca.com>
	<CACdnJuv7ADizvK8omRJA244N65ReYqWT2HSS_T=_uV66wMZ6Sg@mail.gmail.com>
Message-ID: <a1054b8f-cebf-6c4b-be08-524d948b2449@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 1/3/2018 10:11 AM, Matthew Garrett wrote:
> On Wed, Jan 3, 2018 at 7:54 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 1/2/2018 5:20 PM, Matthew Garrett wrote:
>>> Right now most of the IMA code is using current->creds, but the LSM
>>> checks are using security_task_getsecid() which ends up looking at
>>> real_creds. Switch to using security_cred_getsecid() in order to make
>>> this consistent.
>> security_filter_rule_match() is security_audit_rule_match() in
>> sheep's clothing. Using the cred secid in this case, where the
>> task secid is used elsewhere is going to lead to tears. It's
>> going to make *me* cry as I work on untangling secids for
>> stacking/namespaces. I can't predict how else it's going to
>> bite us, but I'm betting on it.
> The problem here is that we don't *have* the task secid for one of the
> cases I care about. Validating the task secid at execution time gives
> us the security context of the spawning process, rather than the
> spawned one - by the time it's committed to the task structure, it's
> too late to block execution, so all we have is the secid associated
> with the creds in the bprm structure. Obviously fixing this in a way
> that doesn't break your work is important, so any suggestions on how I
> should be fixing this? :)

A security module is allowed to manage either or both of
task and cred blobs. How a security module uses secids is
completely up to the module. So far, everyone is using the
secid to be an alias for the secctx, and the task and cred
are treated as (roughly) the same kind of thing. But that's
not guaranteed going forward. I don't know what someone
might want to do that would cause a problem, but people are
amazingly creative.

I'm actually more concerned with the IMA code using the audit
rule matching. There's an assumption that the secid from a
cred and a secid from a task are both acceptable to the audit
system. What if they aren't? It's possible that I'm just
being paranoid, but we're getting too many permutations
(audit/IMA + task/cred) for my liking. 


--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
