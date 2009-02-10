--
-- Copyright (c) 2008 Red Hat, Inc.
--
-- This software is licensed to you under the GNU General Public License,
-- version 2 (GPLv2). There is NO WARRANTY for this software, express or
-- implied, including the implied warranties of MERCHANTABILITY or FITNESS
-- FOR A PARTICULAR PURPOSE. You should have received a copy of GPLv2
-- along with this software; if not, see
-- http://www.gnu.org/licenses/old-licenses/gpl-2.0.txt.
-- 
-- Red Hat trademarks are not licensed under GPLv2. No permission is
-- granted to use or replicate Red Hat trademarks that are incorporated
-- in this software or its documentation. 
--
--
--
--

create table
rhnChannelComps
(
   id                   numeric
                        constraint rhn_channelcomps_id_pk primary key,
   channel_id           numeric
                        not null
                        constraint rhn_channelcomps_cid_fk
                        references rhnChannel(id)
                        on delete cascade,
   relative_filename    varchar(256)
                        not null,
   last_modified        date default(current_date)
                        not null,
   created              date default(current_date)
                        not null,
   modified             date default(current_date)
                        not null
)
  ;

create sequence rhn_channelcomps_id_seq start with 101;

/*
create or replace trigger
rhn_channelcomps_mod_trig
before insert or update on rhnChannelComps
for each row
begin
    :new.modified := sysdate;
    -- allow us to manually set last_modified if we wish
    if :new.last_modified = :old.last_modified
    then
        :new.last_modified := sysdate;
        end if;
end rhn_channelcomps_mod_trig;
/
show errors
*/
