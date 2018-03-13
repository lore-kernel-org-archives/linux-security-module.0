From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Tue, 13 Mar 2018 16:40:10 -0400
Subject: [PATCH v3 0/4] unverifiable file signatures
In-Reply-To: <87zi3bwyql.fsf@xmission.com>
References: <1520540650-7451-1-git-send-email-zohar@linux.vnet.ibm.com>
	<87zi3bwyql.fsf@xmission.com>
Message-ID: <1520973610.3547.366.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 2018-03-13 at 14:40 -0500, Eric W. Biederman wrote:
> Mimi Zohar <zohar@linux.vnet.ibm.com> writes:
> 
> > For local filesystems, the kernel prevents files being executed from
> > being modified.  With IMA-measurement enabled, the kernel also emits
> > audit "time of measure, time of use" messages for files opened for
> > read, and subsequently opened for write.
> >
> > Files on fuse are initially measured, appraised, and audited.  Although
> > the file data can change dynamically any time, making re-measuring,
> > re-appraising, or re-auditing pointless, this patch set attempts to
> > differentiate between unprivileged non-init root and privileged
> > mounted fuse filesystems.
> 
> Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
> 
> Overall ack on the way this is put together.

Thanks you!

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
