From: paul@paul-moore.com (Paul Moore)
Date: Fri, 22 Dec 2017 16:02:41 -0500
Subject: Differentiating audit rules in an LSM stack
In-Reply-To: <a1f773ca-924d-1428-c8b3-0bf77f6cf796@schaufler-ca.com>
References: <a1f773ca-924d-1428-c8b3-0bf77f6cf796@schaufler-ca.com>
Message-ID: <CAHC9VhTDepkZ=073kuP25Jz-XAh4aK94tBb8tNGjxdz6c-1EPA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Dec 22, 2017 at 3:01 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> The audit rule field types AUDIT_SUBJ_* and AUDIT_OBJ_* are
> defined generically and used by both SELinux and Smack to identify
> fields that are interesting to them. If SELinux and Smack are running
> concurrently both modules will identify audit rules as theirs if
> either has requested the field. Before I go off and create a clever
> solution I think it wise to ask if anyone has thought about or has
> strong opinions on how best to address this unfortunate situation.
>
> We know that SELinux and Smack together is not an especially
> interesting configuration. It is, however, a grand test case for
> generality of the solution. Any module that wanted to audit fields
> that are defined generically will have this sort of problem.

I think the biggest concern here is going to be what Steve's audit
userspace will tolerate.  I might suggest simply duplicating the
fields for each LSM that is running, e.g. "subj=<selinux_label>
subj=<smack_label> subj=<lsmX_label> ...", but I have no idea if
Steve's userspace can handle multiple instances of the same field in a
single record.

My initial thinking is that adding LSM-specific subj/obj fields would
be a mistake.

-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
