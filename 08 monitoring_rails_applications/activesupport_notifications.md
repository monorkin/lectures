## Action Controller

| Event | Description |
|-------|-------------|
| write_fragment.action_controller   | Did write to cache |
| read_fragment.action_controller    | Read from cache |
| expire_fragment.action_controller  | Expire fragment in cache |
| exist_fragment?.action_controller  | Inquire request was made to the cache |
| write_page.action_controller       | ??? |
| expire_page.action_controller      | ??? |
| start_processing.action_controller | Request did starts processing |
| process_action.action_controller   | Request has been processed |
| send_file.action_controller        | ??? |
| send_data.action_controller        | ??? |
| redirect_to.action_controller      | Redirect has been made |
| halted_callback.action_controller  | An callback or hook got skipped |

## Action View

| Event | Description |
|-------|-------------|
| render_template.action_view | A view got rendered |
| render_partial.action_view  | A partial got rendered |

## Active Record

| Event | Description |
|-------|-------------|
| sql.active_record           | Database interaction happened |
| instantiation.active_record | A Ruby object got instanciated from DB data |

## Action Mailer

| Event | Description |
|-------|-------------|
| receive.action_mailer | Email has been received |
| deliver.action_mailer | Email has been delivered |

## Active Support

| Event | Description |
|-------|-------------|
| cache_read.active_support      | Data got read from the cache |
| cache_generate.active_support  | ??? |
| cache_fetch_hit.active_support | ??? |
| cache_write.active_support     | Data got written to the cache |
| cache_delete.active_support    | ??? |
| cache_exist?.active_support    | ??? |

## Active Job

| Event | Description |
|-------|-------------|
| enqueue_at.active_job    | Job was enqueued with priority |
| enqueue.active_job       | Job was enqueued |
| perform_start.active_job | Job did start processing |
| perform.active_job       | Job is done |

## Railities

| Event | Description |
|-------|-------------|
| load_config_initializer.railties | Initializer executed |

## Rails

| Event | Description |
|-------|-------------|
| deprecation.rails | Deprication warning message printed |
